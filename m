From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 18 Oct 2019 00:06:23 +0000
Subject: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <071cf1eeefcbfc14633a13bc2d15ad7392987a88.camel@kernel.crashing.org>
References: <20191011213027.2110008-1-vijaykhemka@fb.com>
 <3a1176067b745fddfc625bbd142a41913ee3e3a1.camel@kernel.crashing.org>
 <0C0BC813-5A84-403F-9C48-9447AAABD867@fb.com>
 <071cf1eeefcbfc14633a13bc2d15ad7392987a88.camel@kernel.crashing.org>
Message-ID: <9AA81274-01F2-4803-8905-26F0521486CE@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/17/19, 4:15 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

    On Thu, 2019-10-17 at 22:01 +0000, Vijay Khemka wrote:
    > 
    > On 10/16/19, 6:29 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
    > 
    >     On Fri, 2019-10-11 at 14:30 -0700, Vijay Khemka wrote:
    >     > HW checksum generation is not working for AST2500, specially with
    >     > IPV6
    >     > over NCSI. All TCP packets with IPv6 get dropped. By disabling this
    >     > it works perfectly fine with IPV6. As it works for IPV4 so enabled
    >     > hw checksum back for IPV4.
    >     > 
    >     > Verified with IPV6 enabled and can do ssh.
    >     
    >     So while this probably works, I don't think this is the right
    >     approach, at least according to the comments in skbuff.h
    > 
    > This is not a matter of unsupported csum, it is broken hw csum. 
    > That's why we disable hw checksum. My guess is once we disable
    > Hw checksum, it will use sw checksum. So I am just disabling hw 
    > Checksum.
    
    I don't understand what you are saying. You reported a problem with
    IPV6 checksums generation. The HW doesn't support it. What's "not a
    matter of unsupported csum" ?
    
    Your patch uses a *deprecated* bit to tell the network stack to only do
    HW checksum generation on IPV4.
    
    This bit is deprecated for a reason, again, see skbuff.h. The right
    approach, *which the driver already does*, is to tell the stack that we
    support HW checksuming using NETIF_F_HW_CSUM, and then, in the transmit
    handler, to call skb_checksum_help() to have the SW calculate the
    checksum if it's not a supported type.

My understanding was when we enable NETIF_F_HW_CSUM means network 
stack enables HW checksum and doesn't calculate SW checksum. But as per
this supported types HW checksum are used only for IPV4 and not for IPV6 even
though driver enabled NETIF_F_HW_CSUM. For IPV6 it is always a SW generated
checksum, please correct me here.
    
    This is exactly what ftgmac100_prep_tx_csum() does. It only enables HW
    checksum generation on supported types and uses skb_checksum_help()
    otherwise, supported types being protocol ETH_P_IP and IP protocol
    being raw IP, TCP and UDP.

    
    So this *should* have fallen back to SW for IPV6. So either something
    in my code there is making an incorrect assumption, or something is
    broken in skb_checksum_help() for IPV6 (which I somewhat doubt) or
    something else I can't think of, but setting a *deprecated* flag is
    definitely not the right answer, neither is completely disabling HW
    checksumming.
    
    So can you investigate what's going on a bit more closely please ? I
    can try myself, though I have very little experience with IPV6 and
    probably won't have time before next week.
    
    Cheers,
    Ben.
    
    >     The driver should have handled unsupported csum via SW fallback
    >     already in ftgmac100_prep_tx_csum()
    >     
    >     Can you check why this didn't work for you ?
    >     
    >     Cheers,
    >     Ben.
    >     
    >     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    >     > ---
    >     > Changes since v1:
    >     >  Enabled IPV4 hw checksum generation as it works for IPV4.
    >     > 
    >     >  drivers/net/ethernet/faraday/ftgmac100.c | 13 ++++++++++++-
    >     >  1 file changed, 12 insertions(+), 1 deletion(-)
    >     > 
    >     > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
    >     > b/drivers/net/ethernet/faraday/ftgmac100.c
    >     > index 030fed65393e..0255a28d2958 100644
    >     > --- a/drivers/net/ethernet/faraday/ftgmac100.c
    >     > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
    >     > @@ -1842,8 +1842,19 @@ static int ftgmac100_probe(struct
    >     > platform_device *pdev)
    >     >  	/* AST2400  doesn't have working HW checksum generation */
    >     >  	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
    >     >  		netdev->hw_features &= ~NETIF_F_HW_CSUM;
    >     > +
    >     > +	/* AST2500 doesn't have working HW checksum generation for IPV6
    >     > +	 * but it works for IPV4, so disabling hw checksum and enabling
    >     > +	 * it for only IPV4.
    >     > +	 */
    >     > +	if (np && (of_device_is_compatible(np, "aspeed,ast2500-mac")))
    >     > {
    >     > +		netdev->hw_features &= ~NETIF_F_HW_CSUM;
    >     > +		netdev->hw_features |= NETIF_F_IP_CSUM;
    >     > +	}
    >     > +
    >     >  	if (np && of_get_property(np, "no-hw-checksum", NULL))
    >     > -		netdev->hw_features &= ~(NETIF_F_HW_CSUM |
    >     > NETIF_F_RXCSUM);
    >     > +		netdev->hw_features &= ~(NETIF_F_HW_CSUM |
    >     > NETIF_F_RXCSUM
    >     > +					 | NETIF_F_IP_CSUM);
    >     >  	netdev->features |= netdev->hw_features;
    >     >  
    >     >  	/* register network device */
    >     
    >     
    > 
    
    

