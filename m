From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 1 Oct 2024 08:16:38 +0200
Subject: [PATCH 1/2] ARM: dts: replace gpio = with gpios =
In-Reply-To: <20240930223550.353882-2-rosenp@gmail.com>
References: <20240930223550.353882-1-rosenp@gmail.com>
 <20240930223550.353882-2-rosenp@gmail.com>
Message-ID: <2915d4aa-a01d-4d00-ada9-43bbc227f9eb@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/10/2024 00:35, Rosen Penev wrote:
> Found with dtc:
> 
> Warning (deprecated_gpio_property): '[*-]gpio' is deprecated, use
> '[*-]gpios' instead
> 
> Transformation performed with
> 
> find -name "*.dts" -exec sed -i 's/\tgpio = </\tgpios = </g' '{}' \
> find -name "*.dtsi" -exec sed -i 's/\tgpio = </\tgpios = </g' '{}' \

Uh, no, please check if each is correct and already handled by bindings.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>



Best regards,
Krzysztof

