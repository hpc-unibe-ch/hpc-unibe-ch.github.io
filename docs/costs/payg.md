# Pay-as-you-go (PAYG) Scheme

The PAYG model on UBELIX provides flexible, usage-based billing for HPC resources. It’s ideal for users with sporadic or changing workloads. With PAYG, you only pay for the actual resources you use - there are no upfront payments or long-term commitments.

!!! tip "Debug & Preemptable Jobs"
    Jobs running in **debug** or **preemptable** QOS are **not billed**, allowing you to test and benchmark your code efficiently before committing to longer runs.

## How Pricing Works

- **CPU Nodes:**
  Both CPU and memory usage are billed. Memory is converted to CPU-equivalents for pricing. For example:
  On a node with 128 cores and 1TB of memory, if you use 512GB of memory, you are billed for 64 CPUs, regardless of how many CPUs you actually requested (as long as your CPU request is 64 or less). On the other hand, if you request 72 CPUs and 20GB of memory on the same node, you are billed for 72 CPUs, regardless of the memory you requested. The cost is calculated using the higher value between CPUs and memory used: `max(cpu, mem)`.

- **GPU Nodes:**
  Only GPU usage is billed. CPU and memory use on GPU nodes are not charged separately.

You can always check the latest prices [here](https://intern.unibe.ch/dienstleistungen/informatik/dienstleistungen_der_informatikdienste/dienstleistungen___ressourcen/high_performance_computing___hpc___grid/index_ger.html#tab-pane-3) (internal access or UniBE-VPN required).

!!! success "OPEX Coverage"
    All operational and network costs (such as hardware, licenses, and staff) are covered by **central IT services**.
    This means that **100% of your payments are reinvested into new compute hardware for UBELIX users.**


### UBELIX vs. Cloud Providers

UBELIX offers significantly lower prices than commercial cloud providers—and your bill includes storage, network traffic, and managed software support.

### Research Group / Project Free Tier

Research projects on UBELIX receive an annual credit of **CHF 1000** per cost center. This credit is available only for cost-enabled projects (projects that generate bills for resource usage).

- **How It Works:**
    - Each cost-enabled project receives a monthly bill for HPC resource usage.
    - At the end of the fiscal year, up to CHF 1000 is refunded per cost center (*REF-XX-XXX / REF-XXX-XX*) through an internal transfer (“Umbuchung”).
    - If your cost center's annual usage is less than CHF 1000, the full amount is refunded. If usage is higher, only CHF 1000 is refunded.
    - The refund is applied automatically; no action is required from the user.
    - This credit helps research groups manage costs and supports exploratory work without financial risk.

- **Example:**
    - If your cost center accumulates CHF 800 in costs over the year, you will receive an CHF 800 refund.
    - If your cost center accumulates CHF 1500, you will receive a CHF 1000 refund.

!!! danger "Warning"
    This annual credit is granted once per cost center. Please note that if this is abused, we may have to discontinue the free tier.

## Using PAYG in Practice

- Projects are created and managed in the IAM portal by technical managers. Managers can appoint project administrators ("delegates") to help manage project members.
- Project members are users authorized to use the project’s resources. Every project has a unique identifier ("wckey") that links users to the project.
- When creating a project, a valid credit number and cost limit must be set.
- To submit a job using PAYG:
    - Select the paygo account: `--account=paygo`
    - Specify your project’s wckey: `--wckey=<wckey>`
- Only jobs submitted with the paygo account and a valid wckey will incur costs.
- Each month, UBELIX sends a bill to the credit number associated with your project.

### Notes

- Users can belong to multiple projects and use the relevant wckey for each job.
- You can specify a wckey with the invest or gratis account as well. In these cases, no costs are charged, but the project's resource usage is tracked - helpful for understanding the true cost, even if it isn’t billed.

