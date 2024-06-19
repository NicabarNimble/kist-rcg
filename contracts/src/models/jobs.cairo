#[starknet::contract]
mod JobAssignment {
    use starknet::{
        ContractAddress, get_block_number, get_caller_address, get_contract_address
    };
    use openzeppelin::access::ownable::OwnableComponent;
    use pragma::PragmaRandomness;
    use random::PseudoRandomness;

    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);

    #[abi(embed_v0)]
    impl OwnableImpl = OwnableComponent::OwnableImpl<ContractState>;
    impl InternalImpl = OwnableComponent::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        jobs: LegacyArray<felt252>,
        user_jobs: LegacyMap<ContractAddress, felt252>,
        pragma_vrf_contract_address: ContractAddress,
        use_vrf: bool,
        last_random_number: felt252,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        JobAssigned: JobAssignmentAnnouncement,
        #[flat]
        OwnableEvent: OwnableComponent::Event
    }

    #[derive(Drop, starknet::Event)]
    struct JobAssignmentAnnouncement {
        caller: ContractAddress,
        job: felt252
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        pragma_vrf_contract_address: ContractAddress,
        owner: ContractAddress,
        jobs: Array<felt252>,
        use_vrf: bool
    ) {
        self.ownable.initializer(owner);
        self.pragma_vrf_contract_address.write(pragma_vrf_contract_address);
        self.jobs.write(jobs);
        self.use_vrf.write(use_vrf);
    }

    #[abi(embed_v0)]
    impl JobAssignment of super::IJobAssignment<ContractState> {
        fn request_job(ref self: ContractState) {
            let caller = get_caller_address();
            let jobs_count: u64 = self.jobs.len();

            assert(jobs_count > 0, 'NO_JOBS_AVAILABLE');

            if self.use_vrf.read() {
                PragmaRandomness::request_randomness_from_pragma(self, caller);
            } else {
                PseudoRandomness::request_pseudo_randomness(self, caller);
            }
        }

        fn assign_job(ref self: ContractState) {
            let caller = get_caller_address();
            let random_number: u256 = self.last_random_number.read().into();
            let jobs_count: u64 = self.jobs.len();
            let job_index: u64 = random_number.into() % jobs_count;
            let job: felt252 = self.jobs.read(job_index);

            self.user_jobs.write(caller, job);
            self.emit(
                Event::JobAssigned(
                    JobAssignmentAnnouncement {
                        caller: caller,
                        job: job
                    }
                )
            );
        }

        fn get_assigned_job(self: @ContractState, user: ContractAddress) -> felt252 {
            self.user_jobs.read(user)
        }

        fn set_randomness_method(ref self: ContractState, use_vrf: bool) {
            self.ownable.assert_only_owner();
            self.use_vrf.write(use_vrf);
        }
    }
}
