From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 15 May 2024 16:10:32 +0200
Subject: [PATCH v5 0/4] ARM: dts: aspeed: Add IBM P11 BMC systems
In-Reply-To: <20240514213510.159144-1-eajames@linux.ibm.com>
References: <20240514213510.159144-1-eajames@linux.ibm.com>
Message-ID: <b99b61bd-a271-4dc8-b8fc-ab72df65dc1b@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/05/2024 23:35, Eddie James wrote:
> This series was previously included in
> https://lore.kernel.org/all/20240429210131.373487-1-eajames at linux.ibm.com/
> The series now depends on
> https://lore.kernel.org/all/20240514212555.158788-1-eajames at linux.ibm.com/

No, it does not work like this. Bindings come with the user. Do not
create fake dependencies and DTS must be send TOGETHER with the board
binding.

Best regards,
Krzysztof

