Return-Path: <linux-aspeed+bounces-1867-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE2FC87FD2
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btNcX5RWPz2yFK;
	Fri,  1 Aug 2025 08:12:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753999964;
	cv=none; b=Rl3nxnmTC36gEdL28Pqg8cg5LJn0fc/EerViOF9f5l1QiUHJ41fNSqKYwhI9tO2gpCjMr+GnRWU7K6rpa5C6TqmS3sKByVsrx9UVZGd+DQxB32n1jw8lDUq4N8ESg3dA5KcOelJwfqU4SXLXDxckYFHTSBmunb7R6Z/CwjlJEDy5avFXoBKE0UQbix5YGkpsybE1haT6l4DcOsKvoLVmK7PtH7mZBpvDwtmKYBHdM+bq2mlBlbgZNy2WeP2OmTJ7mAAqfKhyK4/WAoYa4U2wAVJilXxGVRfM/kg7qKXDW8q5Oa/t2fJnvgSx7C9zejScAGaLTe9NHm63Z69EfMlgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753999964; c=relaxed/relaxed;
	bh=n5zF9eYAfet4a2a7y5aVXc8isdMOf/EErsvnjAstrus=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gi8W1Tp9K35fLDtGh0O25DAow/y6DpmhvBb9CvhVu6VJAboZNJSJ0lgwbFxJQJ1nG/uQVmWMX26iTesp7FkgQXsVycS+f8/zMI0NC536ile5/hL+hxodtr8XsPqKJ7Pxbv7M5VQ0T5S1p9l//Ls1UD5vbBrf6p5DBgCXEKHbx/asYSo1C5iYIHL+qnSSLHQgEuLI7chgo3qqMSphGswN3KDq2LhCVn9X7OUOU8ZE+QP3qWOZkGVzZVzw1/5CFGp+NIfmttKWnWSDtVkvcJSjfQTH6EF13RDHZqKK14fKsdtvW1j89Na/EgoWWR8s8Eu9oxf1nJOg30Pv3TMixu4S2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oLJcqY90; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oLJcqY90;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btNcW3C3bz2xRs;
	Fri,  1 Aug 2025 08:12:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 227D543E26;
	Thu, 31 Jul 2025 22:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A0CC4CEEF;
	Thu, 31 Jul 2025 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999960;
	bh=dGSihHIH6s1bKpn+VJDgTQDiIrWhwFA7/h+sIJx6jwg=;
	h=From:Subject:Date:To:Cc:From;
	b=oLJcqY90eQJdOq4+ZVdz9zCLTXxY9bYXetWN3wruycZl68Vv8gOinkMD1NxlUtUU7
	 KKZdgufnrqxghzfCIpcVsP3a4SUL2gkcBcukTJZTEj+TmrSU4/PCG1awNmtn5dsfwy
	 MQNiKrUxOePQXuomTAgaRPMUZCjAaSS+ARkk8dc49O91FthtGs1ySu4P+hycZIzoWw
	 yJwRvZFKpTm8rpsTb9Ayip8A8O1z697Wp/1bZACv9Pq7uqzrOUGwkXbjCRgaCpD/Hs
	 DipIW8Hnun2M+qLnJ1C338nHAPVgDVH0+SoM+e1SA7/1/YEf+h+MhLZLm1EhasDVH7
	 9ZVX0dE4D+2Mw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/6] ASpeed FSI DT clean-ups
Date: Thu, 31 Jul 2025 17:12:17 -0500
Message-Id: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHqi2gC/x3MMQqAMAxA0atIZgNtRQWvIg5qEw1IlUZFKN7d4
 viG/xMoRSGFrkgQ6RaVPWTYsoB5HcNCKD4bnHG1aSuL/kRWwXmjMVyHInvrTVPzZNlAro5ILM9
 /7If3/QC+DbP4YQAAAA==
X-Change-ID: 20250731-dt-fsi-cleanups-fd1d065fb1f0
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

There's a whole bunch of FSI related DT warnings on ASpeed platforms. 
This series fixes most of them except some related to SBEFIFO.

The remaining SBEFIFO warnings are from some deprecated properties noted 
with 'remove when userspace is fixed'. Not sure if they can be removed 
now or soon. If not, perhaps the deprecated properties need to be 
properly documented.

All the patches here are independent, so DTS changes can go via ASpeed 
tree and FSI bindings via FSI tree (or ack if you want me to take the 
bindings instead).

Rob

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (6):
      ARM: dts: aspeed: Drop "no-gpio-delays"
      ARM: dts: aspeed: Drop "fsi-master" compatibles
      ARM: dts: aspeed: Add missing "ibm,spi-fsi" compatibles
      MAINTAINERS: Add FSI bindings to FSI subsystem entry
      dt-bindings: fsi: Convert fsi-master-gpio to DT schema
      dt-bindings: fsi: Convert aspeed,ast2400-cf-fsi-master to DT schema

 .../bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml | 81 ++++++++++++++++++++++
 .../devicetree/bindings/fsi/fsi-master-ast-cf.txt  | 36 ----------
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 28 --------
 .../devicetree/bindings/fsi/fsi-master-gpio.yaml   | 63 +++++++++++++++++
 MAINTAINERS                                        |  1 +
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts | 24 ++++---
 .../boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts |  3 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |  3 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts    |  2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |  3 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts  |  2 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  4 +-
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     | 12 ++--
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi     | 12 ++--
 18 files changed, 188 insertions(+), 94 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250731-dt-fsi-cleanups-fd1d065fb1f0

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>


