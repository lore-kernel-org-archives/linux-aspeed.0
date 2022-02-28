From: Christian König <christian.koenig@amd.com>
Date: Mon, 28 Feb 2022 13:19:17 +0100
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <20220228110822.491923-3-jakobkoschel@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
Message-ID: <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am 28.02.22 um 12:08 schrieb Jakob Koschel:
> If the list does not contain the expected element, the value of
> list_for_each_entry() iterator will not point to a valid structure.
> To avoid type confusion in such case, the list iterator
> scope will be limited to list_for_each_entry() loop.

We explicitly have the list_entry_is_head() macro to test after a loop 
if the element pointer points to the head of the list instead of a valid 
list entry.

So at least from my side I absolutely don't think that this is a good idea.

> In preparation to limiting scope of a list iterator to the list traversal
> loop, use a dedicated pointer to point to the found element.
> Determining if an element was found is then simply checking if
> the pointer is != NULL.

Since when do we actually want to do this?

Take this code here as an example:
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 48afe96ae0f0..6c916416decc 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -450,7 +450,8 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>   				     struct mm_struct *mm)
>   {
>   	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
> -	struct sgx_encl_mm *tmp = NULL;
> +	struct sgx_encl_mm *found_encl_mm = NULL;
> +	struct sgx_encl_mm *tmp;
>
>   	/*
>   	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
> @@ -460,12 +461,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
>   	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
>   		if (tmp == encl_mm) {
>   			list_del_rcu(&encl_mm->list);
> +			found_encl_mm = tmp;
>   			break;
>   		}
>   	}
>   	spin_unlock(&encl_mm->encl->mm_lock);
>
> -	if (tmp == encl_mm) {
> +	if (found_encl_mm) {
>   		synchronize_srcu(&encl_mm->encl->srcu);
>   		mmu_notifier_put(mn);
>   	}

I don't think that using the extra variable makes the code in any way 
more reliable or easier to read.

Regards,
Christian.
