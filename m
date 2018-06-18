From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Jun 2018 15:08:48 +0930
Subject: [PATCH v2 2/4] gpio: aspeed: Add "Read Data" register to read the
 write latch
In-Reply-To: <20180618045352.9489-3-benh@kernel.crashing.org>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
 <20180618045352.9489-3-benh@kernel.crashing.org>
Message-ID: <CACPK8Xcy7ZGTA57ix=zAfPjTKu2B_0efxFT8PymSaYAFGjh56Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18 June 2018 at 14:23, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The Aspeed GPIO hardware has a quirk: the value register, for an
> output GPIO, doesn't contain the last value written (the write
> latch content) but the sampled input value.
>
> This means that when reading back shortly after writing, you can
> get an incorrect value as the input value is delayed by a few
> synchronizers.
>
> The HW supports a separate read-only register "Data Read Register"
> which allows you to read the write latch instead.
>
> This adds the definition for it, and uses it for the initial
> population of the GPIO value cache. It will be used more in
> subsequent patches.
> can be
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
