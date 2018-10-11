From: Justin.Lee1@Dell.com <Justin.Lee1@Dell.com>
Date: Thu, 11 Oct 2018 05:37:46 +0000
Subject: [PATCH net-next v5] net/ncsi: Extend NC-SI Netlink interface to
 allow user space to send NC-SI command
In-Reply-To: <e26c7aa664a2dad4f5bcf4efaa1b3eb655548b01.camel@mendozajonas.com>
References: <245b32d9a3dd463f9334b9704b639ec4@AUSX13MPS302.AMER.DELL.COM>
 <e26c7aa664a2dad4f5bcf4efaa1b3eb655548b01.camel@mendozajonas.com>
Message-ID: <62f859a161f64f7a8f11ba1a99369169@AUSX13MPS302.AMER.DELL.COM>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> On Wed, 2018-10-10 at 18:11 +0000, Justin.Lee1 at Dell.com wrote:
> <snip>
> > +
> > +	len = nla_len(info->attrs[NCSI_ATTR_DATA]);
> > +	if (len < sizeof(struct ncsi_pkt_hdr)) {
> > +		netdev_info(ndp->ndev.dev, "NCSI: no command to send %u\n",
> > +			    package_id);
> > +		ret = -EINVAL;
> > +		goto out_netlink;
> > +	} else {
> > +		data = (unsigned char *)nla_data(info->attrs[NCSI_ATTR_DATA]);
> > +	}
> 
> I only just noticed this, the call to nla_len() can cause a null-dereference if
> the NCSI_ATTR_DATA attribute isn't present; we need to make sure it exists
> before accessing it in info->attrs.
> 
> eg:
> 
> root at ozrom2-bmc:~# ./ncsi-netlink -l 2 -p 0 -c 0 --cmd
> [   81.399837] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [   81.409092] pgd = ddaa9fa6
> [   81.413084] [00000000] *pgd=9702c831, *pte=00000000, *ppte=00000000
> [   81.420729] Internal error: Oops: 17 [#1] ARM
> [   81.426447] CPU: 0 PID: 1028 Comm: ncsi-netlink Not tainted 4.18.8-sammj-00144-gbc129f31bfa5 #12
> ...
> [   81.874434] Kernel panic - not syncing: Fatal exception
> 
> Cheers,
> Sam

Good catch! I will address this and generate the new patch.

Thanks,
Justin
