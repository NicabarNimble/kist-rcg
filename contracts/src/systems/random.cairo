#[starknet::contract]
mod PseudoRandomness {
    use starknet::{get_block_number, get_caller_address};
    use jobs::JobAssignment::assign_job as assign_job_impl;

    fn request_pseudo_randomness(ref self: ContractState, caller: ContractAddress) {
        let block_number = get_block_number();
        let random_number = block_number.into_felt252() ^ caller.to_felt252();
        self.last_random_number.write(random_number);
        assign_job_impl(self);
    }
}
