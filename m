From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 17 Oct 2019 22:01:48 +0000
Subject: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <3a1176067b745fddfc625bbd142a41913ee3e3a1.camel@kernel.crashing.org>
References: <20191011213027.2110008-1-vijaykhemka@fb.com>
 <3a1176067b745fddfc625bbd142a41913ee3e3a1.camel@kernel.crashing.org>
Message-ID: <0C0BC813-5A84-403F-9C48-9447AAABD867@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/16/19, 6:29 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

    On Fri, 2019-10-11 at 14:30 -0700, Vijay Khemka wrote:
    > HW checksum generation is not working for AST2500, specially with
    > IPV6
    > over NCSI. All TCP packets with IPv6 get dropped. By disabling this
    > it works perfectly fine with IPV6. As it works for IPV4 so enabled
    > hw checksum back for IPV4.
    > 
    > Verified with IPV6 enabled and can do ssh.
    
    So while this probably works, I don't think this is the right
    approach, at least according to the comments in skbuff.h

This is not a matter of unsupported csum, it is broken hw csum. 
That's why we disable hw checksum. My guess is once we disable
Hw checksum, it will use sw checksum. So I am just disabling hw 
Checksum.
    
    The driver should have handled unsupported csum via SW fallback
    already in ftgmac100_prep_tx_csum()
    
    Can you check why this didn't work for you ?
    
    Cheers,
    Ben.
    
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    > ---
    > Changes since v1:
    >  Enabled IPV4 hw checksum generation as it works for IPV4.
    > 
    >  drivers/net/ethernet/faraday/ftgmac100.c | 13 ++++++++++++-
    >  1 file changed, 12 insertions(+), 1 deletion(-)
    > 
    > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
    > b/drivers/net/ethernet/faraday/ftgmac100.c
    > index 030fed65393e..0255a28d2958 100644
    > --- a/drivers/net/ethernet/faraday/ftgmac100.c
    > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
    > @@ -1842,8 +1842,19 @@ static int ftgmac100_probe(struct
    > platform_device *pdev)
    >  	/* AST2400  doesn't have working HW checksum generation */
    >  	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
    >  		netdev->hw_features &= ~NETIF_F_HW_CSUM;
    > +
    > +	/* AST2500 doesn't have working HW checksum generation for IPV6
    > +	 * but it works for IPV4, so disabling hw checksum and enabling
    > +	 * it for only IPV4.
    > +	 */
    > +	if (np && (of_device_is_compatible(np, "aspeed,ast2500-mac")))
    > {
    > +		netdev->hw_features &= ~NETIF_F_HW_CSUM;
    > +		netdev->hw_features |= NETIF_F_IP_CSUM;
    > +	}
    > +
    >  	if (np && of_get_property(np, "no-hw-checksum", NULL))
    > -		netdev->hw_features &= ~(NETIF_F_HW_CSUM |
    > NETIF_F_RXCSUM);
    > +		netdev->hw_features &= ~(NETIF_F_HW_CSUM |
    > NETIF_F_RXCSUM
    > +					 | NETIF_F_IP_CSUM);
    >  	netdev->features |= netdev->hw_features;
    >  
    >  	/* register network device */
    
    

