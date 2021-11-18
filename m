From: Kumar Thangavel <kumarthangavel.hcl@gmail.com>
Date: Thu, 18 Nov 2021 13:07:07 +0530
Subject: [PATCH v6] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211117102300.68d00e9a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211117075513.GA12199@gmail.com>
 <20211117102300.68d00e9a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAA7Tbcux55gKoqE9OoPfRcAOO1VkC9hAESHv=Egpjd_vR=M0yQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 17, 2021 at 11:53 PM Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 17 Nov 2021 13:25:13 +0530 Kumar Thangavel wrote:
> > +const int padding_bytes = 26;
>
> net/ncsi/ncsi-cmd.c:21:11: warning: symbol 'padding_bytes' was not
> declared. Should it be static?

Ack.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211118/271b31a7/attachment.htm>
