Return-Path: <linux-aspeed+bounces-4960-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB9EC79F8C
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Sep 2026 05:13:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcyyg316nz2yvG;
	Sun, 06 Sep 2026 15:13:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788671595;
	cv=none; b=PsGP3aHlVbWpSYTbb052l0c9t1xgfbRGK59RTd6nQF89OCTcJVI5Lseirg6E1ACy1aW0RfLRG2DGmRms+wQcTJPTSCFj9XqGlq7W2VG1Qsvuh4o3Sivjx5I6o6NI10vEh2VoSmSnebCgDBtHZY1Z0qJ8FHGa8Kxd5jUTquT6itvtkUbO7cx/uGMEYqHD3oNyBG6ELSh1L1MbwMr0CFOzZR8y+0VZge2596PaHEBXjw+U2uM9BTIBx3UamCx8hyCF14SwmA+ZvbS0SfkDVHbxv7CtPMoQO3iUUtdwsrP2RY4VR7LiLs/KarXBvPJRUUpHVHXsACc7RVhEU9jYBTdRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788671595; c=relaxed/relaxed;
	bh=v00C6G4+vUG94ot1BoePP2klSPMmGYmd1QrEFLUBzpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9qeEV9WEvaJpVai93Amiz+ifrZZITfkygqFNBK54ksiFQS4z0EF6O5QyR2bHc1GDa7h71l+8+ZpiyGbi/X0sNdNTN402Az0bKRsyURGIO8HeaeUCkdnNqyIFTw0VkdsDz+RLJXm/ZwlsAzYJa21Y0E2V7nbsznS/VRemsFf2yGxuYFgniWOUpW5UQhD7JrN3wp7WiMlk5/ZhNWIeOHh0JqzN8anlFIOGxWGuN6FLghh7cTW9n+ZJhYkXzwePB3XPOsoUthfnHmZjADGcsho+laNtD9AAIx7SDOb8FNgokQwQdC/2nAzuu3KTTxZ9dNgAgNYvEU0YaMTLVotVmwZMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kmUqBDJK; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kmUqBDJK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcyyd1lfDz2y2S;
	Sun, 06 Sep 2026 15:13:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=v00C6G4+vUG94ot1BoePP2klSPMmGYmd1QrEFLUBzpQ=; b=kmUqBDJKSYhBP2v2DN8UqDQ3gd
	BSaTTJY7HD21Nx4x4x0as0QZXYmlQxd7wvBF5bbNETGoEWasV3Sr5n+s015dnOgOpdKzVen5Rivi/
	b1S1rzwSYg1OOQtMKrKB+qgLdt7qxlBO/KIu38r1GADGGJEzw8q0PhHJD+maJ/irMrTZYAY8DmaWk
	qYeQdVPcdreXDAF6gRbU0OmbwAvroj5tspKCzSn6Q3MfJXSmeF+vQivhlMNbmqDRpqopR94u1FC3P
	GhOlXrVzrfw/sVmwybrcj7sVBTVJskXiAFiHfvYF/jkmk60nqdPu0r+0+PX7d17tdAgTjqA9Uotag
	VYoWXhMQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x35BM-00000004hpC-2mvt;
	Sun, 06 Sep 2026 05:12:44 +0000
Message-ID: <6168d40d-b781-4abb-9be8-ecb25b7688d5@infradead.org>
Date: Sat, 5 Sep 2026 22:12:43 -0700
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] uart-routing: Add UART Routing driver for StarFive
 JHB100 SoC
To: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Oskar Senft <osk@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Jani Nikula <jani.nikula@intel.com>, Vitaly Lubart <lubvital@gmail.com>,
 Hanjun Guo <guohanjun@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Usyskin
 <alexander.usyskin@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Breno Leitao <leitao@debian.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 James Morse <james.morse@arm.com>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Dave Penkler <dpenkler@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Dan Williams <djbw@kernel.org>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Julian Braha <julianbraha@gmail.com>,
 Karthikeyan KS <karthiproffesional@gmail.com>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
References: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
 <20260905102901.126035-5-changhuang.liang@starfivetech.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905102901.126035-5-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/5/26 3:29 AM, Changhuang Liang wrote:
> Add driver support for JHB100 UART Routing control, allowing runtime
> configuration of RX muxes between UART controllers and I/O pins.
> 
> A sysfs interface is provided for easy checking and updating of routing
> paths.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../sysfs-driver-starfive-uart-routing        |  45 ++++
>  MAINTAINERS                                   |   8 +
>  drivers/uart-routing/Kconfig                  |  13 ++
>  drivers/uart-routing/Makefile                 |   1 +
>  drivers/uart-routing/starfive-uart-routing.c  | 192 ++++++++++++++++++
>  5 files changed, 259 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
>  create mode 100644 drivers/uart-routing/starfive-uart-routing.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
> new file mode 100644
> index 000000000000..737afdf428bc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
> @@ -0,0 +1,45 @@
> +What:		/sys/bus/platform/drivers/starfive-uart-routing/\*/uart\*
> +Date:		August 2026
> +Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
> +Description:	Selects the RX source of the UARTx device.
> +
> +		When read, each file shows the list of available options with currently
> +		selected option marked by brackets "[]". The list of available options
> +		depends on the selected file.
> +
> +		e.g.
> +		cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/uart1
> +		io0 [io1] io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14 uart0 uart1
> +		uart2 uart3 uart4 uart5 uart6 uart7 uart8 uart9 uart10 uart11 uart12 uart13 uart14
> +
> +		In this case, UART1 gets its input from IO1 (physical serial port 1).
> +
> +		To switch the RX source of UART1 to UART2, write the desired source to the file:
> +		echo uart2 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/uart1
> +
> +		This indicates that UART1 now receives its input from UART2.
> +
> +Users:		OpenBMC.  Proposed changes should be mailed to
> +		openbmc@lists.ozlabs.org
> +
> +What:		/sys/bus/platform/drivers/starfive-uart-routing/\*/io\*
> +Date:		August 2026
> +Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
> +Description:	Selects the RX source of IOx serial port. The current selection
> +		will be marked by brackets "[]". The list of available options
> +		depends on the selected file.
> +
> +		e.g.
> +		cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/io9
> +		uart0 uart1 uart2 uart3 uart4 uart5 uart6 uart7 uart8 [uart9] uart10 uart11 uart12
> +		uart13 uart14 io0 io1 io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14
> +
> +		In this case, IO9 (physical serial port 9) gets its input from UART9.
> +
> +		To switch the RX source of IO9 to UART10, write the desired source to the file:
> +		echo uart10 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/io9
> +
> +		This indicates that IO9 now receives its input from UART10.
> +
> +Users:		OpenBMC.  Proposed changes should be mailed to
> +		openbmc@lists.ozlabs.org

Please consider the following changes to this ABI file documentation
(or make your own).

---
Avoid 'make htmldocs' warnings (from docutils) and
make console input or output be presented more clearly and
in a monospace font.

Documentation/ABI/testing/sysfs-driver-starfive-uart-routing:25: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/ABI/testing/sysfs-driver-starfive-uart-routing:1: WARNING: Inline emphasis start-string without end-string. [docutils]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/ABI/testing/sysfs-driver-starfive-uart-routing |   32 +++++-----
 1 file changed, 18 insertions(+), 14 deletions(-)

--- linux-next-20260902.orig/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
+++ linux-next-20260902/Documentation/ABI/testing/sysfs-driver-starfive-uart-routing
@@ -1,4 +1,4 @@
-What:		/sys/bus/platform/drivers/starfive-uart-routing/\*/uart\*
+What:		/sys/bus/platform/drivers/starfive-uart-routing/*/uart*
 Date:		August 2026
 Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
 Description:	Selects the RX source of the UARTx device.
@@ -7,37 +7,41 @@ Description:	Selects the RX source of th
 		selected option marked by brackets "[]". The list of available options
 		depends on the selected file.
 
-		e.g.
-		cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/uart1
-		io0 [io1] io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14 uart0 uart1
-		uart2 uart3 uart4 uart5 uart6 uart7 uart8 uart9 uart10 uart11 uart12 uart13 uart14
+		E.g.::
+
+		  cat /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/uart1
+		  io0 [io1] io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14 uart0 uart1
+		  uart2 uart3 uart4 uart5 uart6 uart7 uart8 uart9 uart10 uart11 uart12 uart13 uart14
 
 		In this case, UART1 gets its input from IO1 (physical serial port 1).
 
-		To switch the RX source of UART1 to UART2, write the desired source to the file:
-		echo uart2 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/uart1
+		To switch the RX source of UART1 to UART2, write the desired source to the file::
+
+		  echo uart2 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/uart1
 
 		This indicates that UART1 now receives its input from UART2.
 
 Users:		OpenBMC.  Proposed changes should be mailed to
 		openbmc@lists.ozlabs.org
 
-What:		/sys/bus/platform/drivers/starfive-uart-routing/\*/io\*
+What:		/sys/bus/platform/drivers/starfive-uart-routing/*/io*
 Date:		August 2026
 Contact:	Changhuang Liang <changhuang.liang@starfivetech.com>
 Description:	Selects the RX source of IOx serial port. The current selection
 		will be marked by brackets "[]". The list of available options
 		depends on the selected file.
 
-		e.g.
-		cat /sys/bus/platform/drivers/starfive-uart-routing/\*.uart-routing/io9
-		uart0 uart1 uart2 uart3 uart4 uart5 uart6 uart7 uart8 [uart9] uart10 uart11 uart12
-		uart13 uart14 io0 io1 io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14
+		E.g.::
+
+		  cat /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/io9
+		  uart0 uart1 uart2 uart3 uart4 uart5 uart6 uart7 uart8 [uart9] uart10 uart11 uart12
+		  uart13 uart14 io0 io1 io2 io3 io4 io5 io6 io7 io8 io9 io10 io11 io12 io13 io14
 
 		In this case, IO9 (physical serial port 9) gets its input from UART9.
 
-		To switch the RX source of IO9 to UART10, write the desired source to the file:
-		echo uart10 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/io9
+		To switch the RX source of IO9 to UART10, write the desired source to the file::
+
+		  echo uart10 > /sys/bus/platform/drivers/starfive-uart-routing/*.uart-routing/io9
 
 		This indicates that IO9 now receives its input from UART10.
 


-- 
~Randy


