From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:40:58 +0930
Subject: [PATCH 04/14] fsi: master-gpio: Rename and adjust send delay
In-Reply-To: <20180626232321.12372-5-benh@kernel.crashing.org>
References: <20180626232321.12372-1-benh@kernel.crashing.org>
 <20180626232321.12372-5-benh@kernel.crashing.org>
Message-ID: <CACPK8XfedsD-PYE-7LBrgsJn1a8J0ogN8m+neBuRC1ecXtj6Yw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:53, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> What the driver called "FSI_GPIO_PRIME_SLAVE_CLOCKS" is what
> the FSI spec calls tSendDelay and should be 16 clocks by
> default.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
