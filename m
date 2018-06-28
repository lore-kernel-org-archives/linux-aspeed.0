From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:43:00 +0930
Subject: [PATCH 14/14] arm: dts: OpenPower Palmetto system can use
 coprocessor for FSI
In-Reply-To: <20180626232605.13420-15-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-15-benh@kernel.crashing.org>
Message-ID: <CACPK8XeLs9URZCO1KnoMmZawSwr9URpCBxn=5gKxKZbJT-p3Uw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This switches away from userspace bitbanging to kernel FSI
> using the coprocessor.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


As with the other patch, I will take this through the ASPEED SoC tree
once we've got acks on the bindings.

Cheers,

Joel
