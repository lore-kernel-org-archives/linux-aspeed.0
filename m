From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 18 Mar 2022 14:44:05 +0100
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks property
In-Reply-To: <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
Message-ID: <ad56b5bc-a9d4-b584-3c04-7c47995381f1@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17/03/2022 20:15, Kuldeep Singh wrote:
> 
> Moreover, clocks also matches incorrectly with the regex pattern.
> Remove this entry altogether to fix it.
> 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

Except of ongoing discussion, this paragraph is incorrect.  There is no
incorrect match of regex pattern. The field is simply not documented in
the bindings (not allowed by bindings). This paragraph is actually
confusing and misleading.


Best regards,
Krzysztof
