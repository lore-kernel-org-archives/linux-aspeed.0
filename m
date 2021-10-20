From: Kumar Thangavel <kumarthangavel.hcl@gmail.com>
Date: Wed, 20 Oct 2021 13:18:49 +0530
Subject: [PATCH v2] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211019075241.7ba9fd0a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211019144127.GA12978@gmail.com>
 <20211019075241.7ba9fd0a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAA7TbcsXCLhzDRuzNgzHFMVqEW3aP7BremDVbedO2eJMG9HFyA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Jakub for your comments.

Please find my response inline below.

On Tue, Oct 19, 2021 at 8:22 PM Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 19 Oct 2021 20:11:27 +0530 Kumar Thangavel wrote:
> >       len += sizeof(struct ncsi_cmd_pkt_hdr) + 4;
> > -     if (nca->payload < 26)
> > +     payload = ALIGN(nca->payload, 4)
> > +     if (payload < 26)
> >               len += 26;
> >       else
> > -             len += nca->payload;
> > +             len += payload;
>
> You round up to 4 and then add 26 if the result is smaller.  26 is not
> a multiple of 4. Is this intentional?
>
>     Kumar :  This is intentional. The total number of bytes should be 64.
This 64 bytes includes Ethernet header, NC-SI header and payload, pldm
header and payload.
                   Some pldm commands payload is less than 26.  So we added
remaining bytes to match with 64 and which is 4 bytes aligned.

Also you can write this on one line:
>
>         len += max(payload, 26);
>

    Kumar : Ack. Will update in the next patch set.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211020/6a0b4c99/attachment.htm>
