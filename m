From: Kumar Thangavel <kumarthangavel.hcl@gmail.com>
Date: Wed, 20 Oct 2021 13:19:55 +0530
Subject: [PATCH v2] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211019120724.50776b81@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211019144127.GA12978@gmail.com>
 <20211019120724.50776b81@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAA7TbcupuBqyq_UhsL6f5723m1afzWJW0+A+jPhY_aKyEAPoMQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 20, 2021 at 12:37 AM Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 19 Oct 2021 20:11:27 +0530 Kumar Thangavel wrote:
> > +     payload = ALIGN(nca->payload, 4)
>
> This is missing a semicolon.
>

    Kumar : Ack. Will fix this in next PS.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211020/866d6c55/attachment.htm>
