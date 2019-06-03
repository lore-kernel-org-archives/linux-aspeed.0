From: Joel Stanley <joel@jms.id.au>
Date: Mon, 3 Jun 2019 09:06:03 +0000
Subject: [PATCH dev-5.1] ARM: dts: aspeed: swift: Add VDD (IR35219) devices
In-Reply-To: <1559334700-51970-1-git-send-email-anoo@linux.ibm.com>
References: <1559334700-51970-1-git-send-email-anoo@linux.ibm.com>
Message-ID: <CACPK8Xc8_SAkxQ1_HTFOkCsV8ejWS=MVXazH+bvDcE=9xKLF8A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2019 at 20:31, Adriana Kobylak <anoo@linux.ibm.com> wrote:
>
> From: Adriana Kobylak <anoo@us.ibm.com>
>
> Add the VDD (IR35219) devices to the Swift device tree.
>
> +       ir35219 at 70 {
> +               compatible = "infineon,ir35219";

There's no driver for these in our tree. Do you have one coming?
