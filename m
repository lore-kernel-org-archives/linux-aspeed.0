Return-Path: <linux-aspeed+bounces-4619-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5098BC55174
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFTyT3FHcz2y8c;
	Wed, 05 Aug 2026 22:20:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785932433;
	cv=none; b=dxOXE+9eA7dnLIqICwxXObDdPkJOJM8qWMro93yPXvuw309ZMOVQD5XnqhIY+nsHNvT8OkRWYZCkxKWLkVkYQdjX6McAVWFLweT0qxEzsjDA3Xz97Fq7kNSBw2C5w5MSMjExV5nmsFMZA1dXbNyQ8mcHw82WQtxAOiT7T3Rgn0Oc1Yx4Eyl587XZqnXtpPkWBuSb8EcXtgy0Uota1ZQCIk0LFE0SiFhpsi+zz9puQKXkvpy/nPcsy57JB71EMIfVI/FQ5x2zaPydP+Gd1Z+kzkJ6nT6qDJ36y8bs64PhKJzOoAaPLrKie33fx6jj9p4w3IRhLs3QrzSjuxvcOf6/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785932433; c=relaxed/relaxed;
	bh=Dp0YqgID/4phtDgYq1gE5Cv1WezComCCtY1tYXFFVXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJITvF6g/I8G4dAt2OmBYQdeqP/aVxrWLJLHZyKFXk14MjgIWuqwmNLHCrO6t1VXkNxuscz/uCixS3h52EkRoKiWKoxnQPBSfOo1YaMShbRRJ7siZ1axdaXRRuiQsbpWrBBGsuX4PtO0wc9Q5TApyXmseev3ah1vqPQnA8HCaJYXXrK+Pd3yL1ORaQ54oVuSJ4MUuTE7aQuqYaV4Qm/Krv1zlafUagWSw+s5tCo5m6D9zSqTueUFOveIP6fzpLeeXXsgCaA7mYXbH6HfaG/x6Qd95VUFiMmW6IYP2bBKrVX4cTJuQSOpAQzwMMc7RtYx+D6MtOOTfEnfEJvNayHHkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=DdUv9ACe; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=DdUv9ACe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFTyS0cMVz2xqM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 22:20:30 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso4461765e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932427; x=1786537227; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dp0YqgID/4phtDgYq1gE5Cv1WezComCCtY1tYXFFVXw=;
        b=DdUv9ACe3w9GWY70ac06Zp1tQ+OkZ0UcNKowX/pnvCDhJw88wDXaftYL+1kxfFDNx8
         eFQrpQxqQ627Bv7zFgsPHYYeXfrzYtBAPhnkyMDg6BjIXRenReiaWfv0J7CiUDFie5wP
         ZqHqjZm6bez0qWcsrneyjliAHoQG7eAxMRwOj+cxLI6jWOf+VwC0QUCaUo73RJNqyKNk
         +hndmqDawVVJopUJH+wnJaLSpWsHX/Tb5rusl2RndUrLaNxEzrjNCCv69xOWMThgU09S
         TdWyJSjmdVLPzJ8lSH+ENhHEYlVCPANn4b0Ruw/BSrHBRwQJh5V+DfnUjBTXewwKAo9W
         Ibyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932427; x=1786537227;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dp0YqgID/4phtDgYq1gE5Cv1WezComCCtY1tYXFFVXw=;
        b=eaAQggNPrjcwOXS5glojL3PSkYple+6692uD9ilixWXX004nAgKKajf9HipC020T0O
         oPcKvQtfcJi9nbzUEqG5GmQd7NfWee+zyKCOyR6Hl8q/ac6F8kQx1M6RRuWKOqrOlM3n
         /87lYE6jOCzVrS6426/WuZ9RvRXTX0fQFpzUpQ31wqgXLeOpJBZfAiWfMotwtGCEcp1N
         7Simv15XwgK/+kNZaF6M2cRMnafmoVrjTZlSMqgTEXajsFn37wt16kXW7nRh2GD/eTCN
         i7SWZkn6JZgh/DViQiVhH5jQUJwDnE671cWM5shnIsCa/iLIKOi8hexWz3Fi6g1IhvWq
         Nitw==
X-Forwarded-Encrypted: i=1; AHgh+RqQLxa3WejFvwPhbqOJRxuzDCUK7Z61GZH5tMZyawhokrk74645IntPHa3/iJ+Kfgveb0fi+E2m+B8qB1o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzuIVk27qSlLSIpN5UpC0BRWLjj5vnDcUtayVbJg60sFuMZ1RPY
	9BhIjArHV+VIqGBUPnIJ4wF3kc6MdY2XQKutJjfcNy68PJudth2fmTKU1s1H2JFA+pw=
X-Gm-Gg: AR+sD10CzS/viuhPPsG9Vp640LEWq48UuwDscZX3X5rNo2Ri5BNIXpHaUZKQ5mbRoRs
	vIaoeMZ7zbh+40itft03dDj+mUGnoBbkkoUObg6OckWy/vfz5M51JG19P7Ce/BGRdnqgF/fw9AR
	jb824XE4wq8rZXs5J5xcL06UXUVEoK2bv2rvYBFpNEOeB16SSaKsTwI68B202Np2idolhkimRo/
	3GdRFLdzmUbal+zUCqsE1tXgZ1SV2orHjxsZNrVJuZ0j2ZdDjyV0hzJLususIv++s0Ygn/uuXSM
	u/P9hFc88SkHFwEU4mSoGt7WpMQkApA0GIaWfg44n160GYangaX4+2KQvxiUtj6oRLQK2c0Cdqv
	Mf2EqUaiNz33McOf4kRBUq8D6nWckeSsYlhDVt3GiLX2eYKIa1ert0aPnWdm954JBFYH5dOt0Cu
	jXXT3uH4fYlawz28VnOsEMde58y6a4dwgvsZPfobYw1QiBiEWRFT7PwHPGynX3XLlPDOp2ZPzbk
	PdCjOqdNPTHy79jHI5QG9nJbH6u/wf9TtrzoUaK7QhvGfHo4+LzgyHe+cykyfKlITu9Fn+eQjrD
X-Received: by 2002:a05:600c:4e87:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-4994e7c0356mr76610975e9.11.1785932426940;
        Wed, 05 Aug 2026 05:20:26 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:26 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 0/6] soc: aspeed: Add BMC and host driver for PCIe BMC device
Date: Wed,  5 Aug 2026 14:19:47 +0200
Message-ID: <cover.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the v5 for upstreaming the VUART over PCIe BMC device drivers.
The initial drivers were taken from the ASPEED kernel SDK
(master-v6.18) [1].

There are two drivers: a BMC-side driver and a host-side driver.
Together they enable host<->BMC VUART communication via PCIe.

The virtual UART is an 8250-compatible register set. It is called
'virtual' because it is internally a simple FIFO.
On the AST2600, two VUARTs can be exposed over PCI via the PCI BMC device.

The host cannot access the BMC's memory. Only the exposed features are
accessible. These are the KCS4 channel and 2 VUARTs. There is also some
mailbox register functionality for a communication between
the host and the BMC. More information can be found here [2].

Changes since v4 [3]:
- Squashed '8250' DT binding changes in one patch based on Krzysztof's
  review.
- Removed 'aspeed,sirq-polarity-sense' support on new
  'aspeed,ast2600-vuart' compatible string as it's a deprecated property.
- Renamed 'syscon' to 'aspeed,scu-syscon' in '8250' DT binding.
- Cleanup in BMC driver:
  - Changed bit 14 to RESERVED macro
  - Changed macros ordering
  - use FIELD_PREP macro
- Cleaned up of the host-side driver:
  - Removed unused INTX. Only use MSI interrupt.
  - Proper use of dev_err_probe.
  - Use of 'module_pci_driver'.
  - Used managed functions and simplified exit code.
- Changed the host side driver location:
  - Now in driver/mfd/aspeed-pci-core.c
  - Changed code to use MFD cells.
    VUART are sub driver of the core driver.
    This allows for easy expansion for KCS support.
  - The core driver now only sets up MSI interrupts and
    instantiates the 8250 sub-driver.

The host driver will performs multiple functions. The AST2600 also
supports LPC over PCI, with a specific KCS channel (KCS4). This host core
driver should also be used to enable the IPMI automatically via this KCS
channel.

Tested:
As with v4, VUART data flow and MSI interrupts have been verified
as working on the test hardware.
BMC: Asus IPMI Kommando Card R1.01, AST2600 A3 running OpenBMC
Host: Linux kernel v7.0.0

This series only supports the AST2600; the AST2700 is not supported.

The findings regarding the MSI interrupt numbers are explained in the v4
cover letter [3].

As with v3 and v4, I would like to know whether I should add the
'lpc-io-reg' and 'lpc-interrupt' values to the vuart3 and vuart4 nodes
directly in the 'aspeed-g6.dtsi'. The host driver is not capable of
finding the vuart address on its own, so they are hardcoded to 0x3f8 and
0x2f8. It will not work with other addresses, so perhaps they should be
in the .dtsi to ensure the correct configuration for the two vuart over
PCI.

[1]: https://github.com/AspeedTech-BMC/linux/tree/aspeed-master-v6.18/drivers/soc/aspeed
[2]: https://lore.kernel.org/linux-aspeed/CAFi2wKYOAotiezepDqaR5PZDqDaPKKDfAEnpx5EHC0mL39hy6w@mail.gmail.com/
[3]: https://lore.kernel.org/linux-aspeed/cover.1783524645.git.gregoire.layet@9elements.com/

Grégoire Layet (6):
  dt-bindings: serial: 8250: aspeed: add ast2600 and
    aspeed,vuart-over-pci
  serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
  serial: 8250_aspeed_vuart: add VUART over PCI
  soc: mfd: add ASPEED AST2600 PCIe BMC device driver
  ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
  ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4

 .../devicetree/bindings/serial/8250.yaml      |  42 +++++-
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  12 +-
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/aspeed-pci-core.c                 | 120 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed_vuart.c   |  92 ++++++++++++++
 7 files changed, 280 insertions(+), 6 deletions(-)
 create mode 100644 drivers/mfd/aspeed-pci-core.c


base-commit: 253b1036b9163f23f7b18274a0d4e904ac8821c5
--
2.54.0

