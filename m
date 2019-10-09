From: Oskar Senft <osk@google.com>
Date: Wed, 9 Oct 2019 14:20:59 -0400
Subject: [PATCH] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <95e215664612c0487808c02232852ef2188c95a5.camel@kernel.crashing.org>
References: <20190910213734.3112330-1-vijaykhemka@fb.com>
 <bd5eab2e-6ba6-9e27-54d4-d9534da9d5f7@gmail.com>
 <CACPK8XcS4iKfKigPbPg0BFbmjbT-kdyjiPDXjk1k5XaS5bCdAA@mail.gmail.com>
 <95e215664612c0487808c02232852ef2188c95a5.camel@kernel.crashing.org>
Message-ID: <CABoTLcQ=N4ugYeo5jxbGtBR0nbu_Ri-OV4pE0PP-yvwXX7W+uw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Does HW in the AST2500 actually perform the HW checksum calculation,
or would that be the responsibility of the NIC that it's talking to
via NC-SI?

(Sorry for the double posting! I had HTML mode enabled by default
which causes the e-mail to be dropped in some places)


On Wed, Oct 9, 2019 at 12:38 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2019-09-11 at 14:48 +0000, Joel Stanley wrote:
> > Hi Ben,
> >
> > On Tue, 10 Sep 2019 at 22:05, Florian Fainelli <f.fainelli@gmail.com>
> > wrote:
> > >
> > > On 9/10/19 2:37 PM, Vijay Khemka wrote:
> > > > HW checksum generation is not working for AST2500, specially with
> > > > IPV6
> > > > over NCSI. All TCP packets with IPv6 get dropped. By disabling
> > > > this
> > > > it works perfectly fine with IPV6.
> > > >
> > > > Verified with IPV6 enabled and can do ssh.
> > >
> > > How about IPv4, do these packets have problem? If not, can you
> > > continue
> > > advertising NETIF_F_IP_CSUM but take out NETIF_F_IPV6_CSUM?
> > >
> > > >
> > > > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > > > ---
> > > >  drivers/net/ethernet/faraday/ftgmac100.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > index 030fed65393e..591c9725002b 100644
> > > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > > @@ -1839,8 +1839,9 @@ static int ftgmac100_probe(struct
> > > > platform_device *pdev)
> > > >       if (priv->use_ncsi)
> > > >               netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> > > >
> > > > -     /* AST2400  doesn't have working HW checksum generation */
> > > > -     if (np && (of_device_is_compatible(np, "aspeed,ast2400-
> > > > mac")))
> > > > +     /* AST2400  and AST2500 doesn't have working HW checksum
> > > > generation */
> > > > +     if (np && (of_device_is_compatible(np, "aspeed,ast2400-
> > > > mac") ||
> > > > +                of_device_is_compatible(np, "aspeed,ast2500-
> > > > mac")))
> >
> > Do you recall under what circumstances we need to disable hardware
> > checksumming?
>
> Any news on this ? AST2400 has no HW checksum logic in HW, AST2500
> should work for IPV4 fine, we should only selectively disable it for
> IPV6.
>
> Can you do an updated patch ?
>
> Cheers,
> Ben.
>
