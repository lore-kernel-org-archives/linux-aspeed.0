From: Tao Ren <rentao.bupt@gmail.com>
Date: Mon, 10 Feb 2020 11:16:30 -0800
Subject: [PATCH 1/3] usb: gadget: aspeed: read vhub config from
 of_device_id
In-Reply-To: <CACPK8Xe0b+zVNqf8v5YXOLkzqDeb4JHqec-bqFpaVFGTwHThhA@mail.gmail.com>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
 <20200131222157.20849-2-rentao.bupt@gmail.com>
 <CACPK8Xe0b+zVNqf8v5YXOLkzqDeb4JHqec-bqFpaVFGTwHThhA@mail.gmail.com>
Message-ID: <20200210191629.GB5346@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 10, 2020 at 02:47:02AM +0000, Joel Stanley wrote:
> On Fri, 31 Jan 2020 at 22:22, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch moves hardcoded vhub attributes (maximum downstream ports and
> > generic endpoints) to "ast_vhub_config" structure which is attached to
> > struct of_device_id. The major purpose is to add AST2600 vhub support
> > because AST2600 vhub provides more downstream ports and endpoints.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> This looks generally okay. We should wait for Ben's ack before applying.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks Joel for reviewing the patches.

Cheers,

Tao
