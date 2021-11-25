From: Kumar Thangavel <kumarthangavel.hcl@gmail.com>
Date: Thu, 25 Nov 2021 15:26:27 +0530
Subject: [PATCH v8] net/ncsi : Add payload to be 32-bit aligned to fix
 dropped packets
In-Reply-To: <163775520854.1662.10651574507891086617.git-patchwork-notify@kernel.org>
References: <20211122163818.GA11306@gmail.com>
 <163775520854.1662.10651574507891086617.git-patchwork-notify@kernel.org>
Message-ID: <CAA7TbcvDeH5sCULo+2rEhZ5ZTht2vPF3uVh4knt7r77JquH4fA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Awesome, thanks!

On Wed, Nov 24, 2021 at 5:30 PM <patchwork-bot+netdevbpf@kernel.org> wrote:

> Hello:
>
> This patch was applied to netdev/net.git (master)
> by David S. Miller <davem@davemloft.net>:
>
> On Mon, 22 Nov 2021 22:08:18 +0530 you wrote:
> > Update NC-SI command handler (both standard and OEM) to take into
> > account of payload paddings in allocating skb (in case of payload
> > size is not 32-bit aligned).
> >
> > The checksum field follows payload field, without taking payload
> > padding into account can cause checksum being truncated, leading to
> > dropped packets.
> >
> > [...]
>
> Here is the summary with links:
>   - [v8] net/ncsi : Add payload to be 32-bit aligned to fix dropped packets
>     https://git.kernel.org/netdev/net/c/ac132852147a
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211125/65a88ed8/attachment.htm>
