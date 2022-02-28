From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 28 Feb 2022 16:12:55 +0300
Subject: [PATCH 6/6] treewide: remove check of list iterator against head
 past the loop body
In-Reply-To: <20220228110822.491923-7-jakobkoschel@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-7-jakobkoschel@gmail.com>
Message-ID: <20220228131255.GC2812@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 28, 2022 at 12:08:22PM +0100, Jakob Koschel wrote:
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
> index 2a7abf7a1f7f..a069847b56aa 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -1239,7 +1239,7 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
>  	struct hfi1_ctxtdata *rcd = flow->req->rcd;
>  	struct hfi1_devdata *dd = rcd->dd;
>  	u32 ngroups, pageidx = 0;
> -	struct tid_group *group = NULL, *used;
> +	struct tid_group *group = NULL, *used, *tmp;
>  	u8 use;
> 
>  	flow->tnode_cnt = 0;
> @@ -1248,13 +1248,15 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
>  		goto used_list;
> 
>  	/* First look at complete groups */
> -	list_for_each_entry(group,  &rcd->tid_group_list.list, list) {
> -		kern_add_tid_node(flow, rcd, "complete groups", group,
> -				  group->size);
> +	list_for_each_entry(tmp,  &rcd->tid_group_list.list, list) {
> +		kern_add_tid_node(flow, rcd, "complete groups", tmp,
> +				  tmp->size);
> 
> -		pageidx += group->size;
> -		if (!--ngroups)
> +		pageidx += tmp->size;
> +		if (!--ngroups) {
> +			group = tmp;
>  			break;
> +		}
>  	}
> 
>  	if (pageidx >= flow->npagesets)
> @@ -1277,7 +1279,7 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
>  	 * However, if we are at the head, we have reached the end of the
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  	 * complete groups list from the first loop above
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  	 */

Originally this code tested for an open code list_is_head() so the
comment made sense, but it's out of date now.  Just delete it.


> -	if (group && &group->list == &rcd->tid_group_list.list)
> +	if (!group)
>  		goto bail_eagain;
>  	group = list_prepare_entry(group, &rcd->tid_group_list.list,
>  				   list);

regards,
dan carpenter
