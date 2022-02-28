From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 28 Feb 2022 16:13:25 +0300
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <20220228110822.491923-3-jakobkoschel@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
Message-ID: <20220228131325.GC2794@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 28, 2022 at 12:08:18PM +0100, Jakob Koschel wrote:
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 4ee578b181da..a8cbd90db9d2 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -1060,26 +1060,29 @@ EXPORT_SYMBOL(sas_port_get_phy);
>   * connected to a remote device is a port, so ports must be formed on
>   * all devices with phys if they're connected to anything.
>   */
> -void sas_port_add_phy(struct sas_port *port, struct sas_phy *phy)
> +void sas_port_add_phy(struct sas_port *port, struct sas_phy *_phy)

_phy is an unfortunate name.

>  {
>  	mutex_lock(&port->phy_list_mutex);
> -	if (unlikely(!list_empty(&phy->port_siblings))) {
> +	if (unlikely(!list_empty(&_phy->port_siblings))) {
>  		/* make sure we're already on this port */
> +		struct sas_phy *phy = NULL;

Maybe call this port_phy?

>  		struct sas_phy *tmp;
> 
>  		list_for_each_entry(tmp, &port->phy_list, port_siblings)
> -			if (tmp == phy)
> +			if (tmp == _phy) {
> +				phy = tmp;
>  				break;
> +			}
>  		/* If this trips, you added a phy that was already
>  		 * part of a different port */
> -		if (unlikely(tmp != phy)) {
> +		if (unlikely(!phy)) {
>  			dev_printk(KERN_ERR, &port->dev, "trying to add phy %s fails: it's already part of another port\n",
> -				   dev_name(&phy->dev));
> +				   dev_name(&_phy->dev));
>  			BUG();
>  		}
>  	} else {
> -		sas_port_create_link(port, phy);
> -		list_add_tail(&phy->port_siblings, &port->phy_list);
> +		sas_port_create_link(port, _phy);
> +		list_add_tail(&_phy->port_siblings, &port->phy_list);
>  		port->num_phys++;
>  	}
>  	mutex_unlock(&port->phy_list_mutex);

regards,
dan carpenter
