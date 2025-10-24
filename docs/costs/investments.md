# Investment Model

The **Investment Model** is ideal for projects that run continuously and require reliable access to compute resources.
By committing to a period of 12–60 months, users receive a **pseudo-exclusive allocation** at a reduced cost — with potential savings of up to **30%** compared to the PAYG model.

Unused portions of these investments are made available to others as **preemptable resources**, ensuring cluster efficiency.

Projects that need **continuous computing** and **short waiting times** and have a solid understanding of their **resource requirements** should consider this option for the best long-term value.

## Pricing

Investment prices are based on CAPEX depreciation over five years, with a 6% annual reduction for committed duration.
All other costs to run and maintain the invested hardware, including power, cooling, staff, licenses, e.g. are covered by the IT office of the University of Bern.

Get an estimate for investment prices using the [UBELIX Calculator (internal only)](https://ubelix.hpc.unibe.ch/calculator).

## Features:
- Pseudo-exclusive access (minimal queuing). Pseudo-exclusive usage in terms of CPU nodes or GPUs means that the nodes are shared with all other users but the
investor is given the right to preempt running jobs from others to have their own jobs start almost immediately.
- Unused resources become free for others via [preemptable QOS](../runjobs/scheduled-jobs/preemption.md)
- Funds reinvested in hardware upgrades.


## Limits
- Investments are limited to resource-types which are already available. If we do not provide a certain type of hardware, please get in touch
- Investing does not come with a SLA[^1] or an extended support-contract.
- There is an upper and lower limit on individual investments as well as the total fraction of investor resources on UBELIX . Use the calculator and/or contact us if unsure.

## How Investor Resources Work in Practice

When an investment is made in UBELIX, resource access is managed according to the type of investment:

- **CPU Investments:**
  For CPU-based investments, we create a dedicated investor partition named `icpu-<investor>`. This partition is reserved for the investor’s resources.

- **GPU Investments:**
  For GPU-based investments, we set up a specific Quality of Service (QOS) called `job_gpu_<investor>` on the `gpu-invest` partition. This QOS ensures that GPU resources are allocated according to the investor’s contribution.

### Granting Access
Investors have the ability to designate specific users who can access their invested resources. These users are granted an association with the invest account and the corresponding investor partition or QOS. This means they can submit jobs that use the resources funded by the investment.

[^1]: Service-level agreement. A service-level agreement (SLA) is an agreement, typically a binding contract, between a service provider and a customer that define particular aspects of the service – such as quality of service, availability, responsibilities.
