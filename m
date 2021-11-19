From: Kumar Thangavel <kumarthangavel.hcl@gmail.com>
Date: Fri, 19 Nov 2021 13:44:42 +0530
Subject: [PATCH v7] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211118223228.7edfeade@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211118160301.GA19542@gmail.com>
 <20211118223228.7edfeade@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAA7TbctSATJ3w_4y+btdfbjs7GTx9BptGZ3QKUjjX_Up+15thA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 19, 2021 at 12:02 PM Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 18 Nov 2021 21:33:02 +0530 Kumar Thangavel wrote:
> > +const static int padding_bytes = 26;
>
> /net/ncsi/ncsi-cmd.c:21:1: warning: ?static? is not at beginning of
> declaration [-Wold-style-declaration]
>    21 | const static int padding_bytes = 26;
>

ACK.

>       | ^~~~~
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211119/44ad68ca/attachment.htm>
