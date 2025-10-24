# Costs and Investment

Starting 2026, the University of Bern is introducting a **fair and transparent pricing scheme** for usage of compute resources on UBELIX. This change aims to make the system fair, sustainable, and transparent - ensuring that resources are used efficiently, while keeping UBELIX accessible to all members of the University of Bern.

The introduction of billing for UBELIX resources represents a significant shift in how we approach high-performance computing at the University of Bern. This change has been carefully considered, with the billing scheme designed to be SNF-compliant and pricing set at highly competitive rates compared to commercial alternatives.
By implementing a pricing structure that includes investment options, pay-as-you-go pricing, and free tiers, we aim to:

   - Foster more efficient and responsible use of computing resources
   - Enable the acquisition of external funding through SNF-compliant billing
   - Ensure fair and transparent distribution of available resources
   - Create a sustainable growth model for UBELIX
   - Promote shared responsibility among the user community

In essence, this change is not meant to restrict access — it’s designed to make UBELIX a **self-sustaining research platform** that can continue to evolve with user needs.

!!! success "OPEX Coverage"
    All operational and network costs (non-compute hardware, licenses, staff, etc.) are covered by **central IT services**,
    meaning that **100% of the billed income is reinvested** into compute hardware for users.
## Benefits for Researchers

Far from being merely an additional cost, the new billing scheme offers several advantages for researchers:

   - More Resources: Revenue generated will be reinvested in expanding and upgrading UBELIX capabilities
   - Better Planning: Transparent costs allow for better project planning and budgeting
   - External Funding: The ability to include HPC costs in grant applications
   - Shorter Wait Times: More efficient resource utilization will reduce queue times
   - Continued Accessibility: Free tiers ensure that small projects, students, and unfunded research still have access

## Usage Options

UBELIX offers **three pricing options**, allowing flexibility depending on your project’s funding, scale, and duration:

1. [**Investment Model**](investments.md) – for long-term, intensive compute use.
2. [**Pay-as-you-Go (PAYG)**](payg.md) – for flexible workloads.
3. [**Free Tiers (F1–F3)**](freetier.md) – for students, teaching, and small unfunded projects.


## How this works in practice

UBELIX uses a combination of accounts and projects to manage resource access and billing under the new pricing scheme. Here’s how it works:

### Account Types

There are three types of accounts, each with different resource access and cost implications:

- **gratis Account**
  The default account for all users. It is free to use and restricted in resources. Every user has access to a gratis account, which never incurs costs.

- **paygo Account**
  The "pay as you go" account is available to users who are members of cost-enabled research projects. When submitting jobs with this account, users must specify a valid project identifier ("wckey") for accounting. Costs are generated at job submission based on actual resource usage.

- **invest Account**
  The investor account distinguishes between free resources (gratis) and resources funded by investment. This account is available to users associated with a UBELIX investment. Jobs submitted under this account do not generate costs at submission; all costs are prepaid through the investment.

### Cost-enabled Research Projects

- Projects are created and managed in the IAM portal by technical managers. Managers can appoint additional project administrators (“delegates”) to manage project members.
- Project members are those who can use the project’s resources. The wckey associates users with projects and is required for job submissions that incur costs.
- During project creation, a credit number and a cost limit must be specified.
- Each project has a unique identifier called a "wckey" that is used during job
  submission
- Users may belong to multiple projects and use their associated wckeys as needed.
- Jobs only generate costs if submitted using the paygo account with a valid wckey.
- wckeys can also be specified when submitting jobs with invest or gratis accounts. In these cases, no additional costs are incurred, but resource usage is tracked for the project. This allows visibility into the true cost of a project, not just the billed cost.
