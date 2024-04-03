From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 03 Apr 2024 13:59:17 +1030
Subject: [PATCH 2/3] ARM: dts: Disable unused ADC channels for Asrock
 X570D4U BMC
In-Reply-To: <20240329130152.878944-3-renze@rnplus.nl>
References: <20240329130152.878944-1-renze@rnplus.nl>
	 <20240329130152.878944-3-renze@rnplus.nl>
Message-ID: <42e91dc2bccdcac96abd729def8a05b2612488a7.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Renze,

On Fri, 2024-03-29 at 14:01 +0100, Renze Nicolai wrote:
> This commit disables unused ADC channels and labels the ADC channels used with their function.

Please run this through checkpatch and address the warnings.

Also, the submitting patches documentation[1] suggests using the
imperative mood - instead of "This commit disables ...", use "Disable
...". The change subject is phrased the expected way.

[1]: https://docs.kernel.org/process/submitting-patches.html

Taking the subject and the description together, the description feels
a little redundant. Maybe it could be trimmed back to

> Also, label the ADC channels used with their function.

Andrew

