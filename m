From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 13 Mar 2024 12:08:01 +0100
Subject: [PATCH v2] pinctrl: pinctrl-aspeed-g6: Fix register offset for
 pinconf of GPIOR-T
In-Reply-To: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
References: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
Message-ID: <6f2af609-e3fc-426b-a7ee-b83b859af09f@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Billy,


Thank you very much for sending version 2.


Am 13.03.24 um 10:28 schrieb Billy Tsai:
> The register offset to disable the internal pull-down of GPIOR~T is 0x630
> instead of 0x620, as specified in the Ast2600 datasheet v15
> The datasheet can download from the official Aspeed website.

(No need for another iteration for this, but ?can be downloaded?.)

> Fixes: 15711ba6ff19 ("pinctrl: aspeed-g6: Add AST2600 pinconf support")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 34 +++++++++++-----------
>   1 file changed, 17 insertions(+), 17 deletions(-)

[?]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
