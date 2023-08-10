From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Thu, 10 Aug 2023 09:48:01 +0200
Subject: [PATCH -next 0/5] rtc: remove redundant of_match_ptr()
In-Reply-To: <20230808115213.154377-1-wangzhu9@huawei.com>
References: <20230808115213.154377-1-wangzhu9@huawei.com>
Message-ID: <169165359721.972357.2241425230708767028.b4-ty@bootlin.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Tue, 08 Aug 2023 19:52:08 +0800, Zhu Wang wrote:
> The driver depends on CONFIG_OF, so it is not necessary to use
> of_match_ptr() here. We remove of_match_ptr().
> 
> Zhu Wang (5):
>   rtc: aspeed: remove redundant of_match_ptr()
>   rtc: at91sam9: remove redundant of_match_ptr()
>   rtc: nct3018y: remove redundant of_match_ptr()
>   rtc: armada38x: remove redundant of_match_ptr()
>   rtc: at91rm9200: remove redundant of_match_ptr()
> 
> [...]

Applied, thanks!

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
