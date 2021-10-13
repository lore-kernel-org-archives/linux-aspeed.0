From: Kumar Thangavel <kumarthangavel.hcl@gmail.com>
Date: Wed, 13 Oct 2021 18:35:29 +0530
Subject: [PATCH] net: ncsi: Adding padding bytes in the payload
In-Reply-To: <dd6df3ee84110649d901f041883c3d44c0798cda.camel@mendozajonas.com>
References: <20211012062240.GA5761@gmail.com>
 <CACPK8XcJudWoKgXORvRzGAbtBwHm3a56RULriVABfERZgNgt9w@mail.gmail.com>
 <dd6df3ee84110649d901f041883c3d44c0798cda.camel@mendozajonas.com>
Message-ID: <CAA7TbctAN9Uck8niYaQNrvaFaKHF4wiJy-F_-+_+D6SWJr9a_A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for your review. Please find my response below.

Fixed all the comments. I will update the next patchset.

Thanks,
Kumar.

On Wed, Oct 13, 2021 at 8:16 AM Samuel Mendoza-Jonas <sam@mendozajonas.com>
wrote:

> On Tue, 2021-10-12 at 22:44 +0000, Joel Stanley wrote:
> > On Tue, 12 Oct 2021 at 06:23, Kumar Thangavel
> > <kumarthangavel.hcl@gmail.com> wrote:
> > >
> > > Update NC-SI command handler (both standard and OEM) to take into
> > > account of payload paddings in allocating skb (in case of payload
> > > size is not 32-bit aligned).
> > >
> > > The checksum field follows payload field, without taking payload
> > > padding into account can cause checksum being truncated, leading to
> > > dropped packets.
> >
> > Can you help us review this by pointing out where this is described in
> > the NCSI spec?
> >
> > We've been running this code for a number of years now and I wonder
> > why this hasn't been a problem so far.
>
> I'm assuming this is referencing section 8.2.2.2:
> If the payload is present and does not end on a 32-bit boundary, one to
> three padding bytes equal to 0x00 shall be present to align the
> checksum field to a 32-bit boundary.
>

Kumar : Yes. In the NC-SI spec, section 8.2.2.2 represents a 32-bit
boundary.
              If it does not end on a 32-bit boundary, padding bytes can be
added.

>
> But I'm also surprised this hasn't caused issues so far if we've been
> getting it wrong. Is there an example that reproduces the issue?
>

Kumar :  We have a use case of NIC firmware update in our system which is
pldm based and the transport layer is NC-SI based on RBT.
               Sending some pldm based commands to NIC. In that, some of
the commands failed because of a payload size less than 32.
               So, Added padding bytes to align the 32-bit boundary and
issues got resolved.


>
> Cheers,
> Sam
>
> >
> > Cheers,
> >
> > Joel
> >
> > >
> > > Signed-off-by: Kumar Thangavel <thangavel.k@hcl.com>
> > >
> > > ---
> > >  net/ncsi/ncsi-cmd.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
> > > index ba9ae482141b..4625fc935603 100644
> > > --- a/net/ncsi/ncsi-cmd.c
> > > +++ b/net/ncsi/ncsi-cmd.c
> > > @@ -214,11 +214,19 @@ static int ncsi_cmd_handler_oem(struct sk_buff
> > > *skb,
> > >         struct ncsi_cmd_oem_pkt *cmd;
> > >         unsigned int len;
> > >
> > > +       /* NC-SI spec requires payload to be padded with 0
> > > +        * to 32-bit boundary before the checksum field.
> > > +        * Ensure the padding bytes are accounted for in
> > > +        * skb allocation
> > > +        */
> > > +
> > > +       unsigned short payload = ALIGN(nca->payload, 4);
> > > +
> > >         len = sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> > > -       if (nca->payload < 26)
> > > +       if (payload < 26)
> > >                 len += 26;
> > >         else
> > > -               len += nca->payload;
> > > +               len += payload;
> > >
> > >         cmd = skb_put_zero(skb, len);
> > >         memcpy(&cmd->mfr_id, nca->data, nca->payload);
> > > @@ -272,6 +280,7 @@ static struct ncsi_request
> > > *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
> > >         struct net_device *dev = nd->dev;
> > >         int hlen = LL_RESERVED_SPACE(dev);
> > >         int tlen = dev->needed_tailroom;
> > > +       int payload;
> > >         int len = hlen + tlen;
> > >         struct sk_buff *skb;
> > >         struct ncsi_request *nr;
> > > @@ -281,14 +290,18 @@ static struct ncsi_request
> > > *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
> > >                 return NULL;
> > >
> > >         /* NCSI command packet has 16-bytes header, payload, 4 bytes
> > > checksum.
> > > +        * Payload needs padding so that the checksum field follwoing
> > > payload is
> > > +        * aligned to 32bit boundary.
> > >          * The packet needs padding if its payload is less than 26
> > > bytes to
> > >          * meet 64 bytes minimal ethernet frame length.
> > >          */
> > >         len += sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> > > -       if (nca->payload < 26)
> > > +
> > > +       payload = ALIGN(nca->payload, 4);
> > > +       if (payload < 26)
> > >                 len += 26;
> > >         else
> > > -               len += nca->payload;
> > > +               len += payload;
> > >
> > >         /* Allocate skb */
> > >         skb = alloc_skb(len, GFP_ATOMIC);
> > > --
> > > 2.17.1
> > >
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211013/9a86416c/attachment-0001.htm>
