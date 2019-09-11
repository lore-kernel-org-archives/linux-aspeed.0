From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Sep 2019 14:48:54 +0000
Subject: [PATCH] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <bd5eab2e-6ba6-9e27-54d4-d9534da9d5f7@gmail.com>
References: <20190910213734.3112330-1-vijaykhemka@fb.com>
 <bd5eab2e-6ba6-9e27-54d4-d9534da9d5f7@gmail.com>
Message-ID: <CACPK8XcS4iKfKigPbPg0BFbmjbT-kdyjiPDXjk1k5XaS5bCdAA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ben,

On Tue, 10 Sep 2019 at 22:05, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 9/10/19 2:37 PM, Vijay Khemka wrote:
> > HW checksum generation is not working for AST2500, specially with IPV6
> > over NCSI. All TCP packets with IPv6 get dropped. By disabling this
> > it works perfectly fine with IPV6.
> >
> > Verified with IPV6 enabled and can do ssh.
>
> How about IPv4, do these packets have problem? If not, can you continue
> advertising NETIF_F_IP_CSUM but take out NETIF_F_IPV6_CSUM?
>
> >
> > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > ---
> >  drivers/net/ethernet/faraday/ftgmac100.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> > index 030fed65393e..591c9725002b 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -1839,8 +1839,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
> >       if (priv->use_ncsi)
> >               netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> >
> > -     /* AST2400  doesn't have working HW checksum generation */
> > -     if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
> > +     /* AST2400  and AST2500 doesn't have working HW checksum generation */
> > +     if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
> > +                of_device_is_compatible(np, "aspeed,ast2500-mac")))

Do you recall under what circumstances we need to disable hardware checksumming?

Cheers,

Joel

> >               netdev->hw_features &= ~NETIF_F_HW_CSUM;
> >       if (np && of_get_property(np, "no-hw-checksum", NULL))
> >               netdev->hw_features &= ~(NETIF_F_HW_CSUM | NETIF_F_RXCSUM);
> >
>
>
> --
> Florian
