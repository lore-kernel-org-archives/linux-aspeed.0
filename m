From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Jun 2022 05:34:26 +0000
Subject: (subset) [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
In-Reply-To: <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-7-krzysztof.kozlowski@linaro.org> <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
Message-ID: <CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Jun 2022 at 10:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On Sun, 29 May 2022 12:49:28 +0200, Krzysztof Kozlowski wrote:
> > "qualcomm" is not a documented compatible and instead "qcom" should be
> > used.
> >
> >
>
> Applied, thanks!

What tree did you apply this to? Did you get review from the maintainer?

This board is unmaintained and unused. I would prefer it removed
rather than meaningless fixes be applied.

>
> [7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
>       https://git.kernel.org/krzk/linux/c/6202c6063145cf9ec22b40aac219122dd702a10f
>
> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
