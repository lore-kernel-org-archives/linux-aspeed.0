From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 25 Sep 2023 11:58:48 +0200
Subject: [PATCH 00/40] soc: Convert to platform remove callback returning
 void
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
Message-ID: <311837de-5acb-4b5b-b64d-9bdc1403a087@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25.09.2023 11:54, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series converts all platform drivers below drivers/soc to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org> # qcom

Konrad
