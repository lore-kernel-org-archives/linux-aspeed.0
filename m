From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Jun 2018 15:08:34 +0930
Subject: [PATCH v2 1/4] gpio: aspeed: Rework register type accessors
In-Reply-To: <20180618045352.9489-2-benh@kernel.crashing.org>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
 <20180618045352.9489-2-benh@kernel.crashing.org>
Message-ID: <CACPK8XehLwd0P9E2=X5pWDrL5ZTu6=70p-2nj2JvUM6kyG9URw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18 June 2018 at 14:23, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Use a single accessor function for all register types instead
> of several spread around. This will make it easier/cleaner
> to introduce new registers and keep the mechanism in one
> place.
>
> The big switch/case is optimized at compile time since the
> switch value is a constant.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
