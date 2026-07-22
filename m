Return-Path: <linux-aspeed+bounces-4536-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05A3C44536
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 15:14:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4yTf1GCyz2yVd;
	Thu, 23 Jul 2026 01:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784733270;
	cv=none; b=bk84/H8SpMY1bw9hF2aichY3c0CGO6O8OawStrhMxCXw5EEi3J3+PdsNR5JdworsD0BIdnMRbYdZ/QH4UncVhEBYlzT3eHhUiXFHwmmNyFXor0UpMa2ZtTa0vFOdaxWL+tCpqmJtonnbHzu91qW3c5/tTJ6Vm5a+iH0awSbcaapyd4Hr9vEqNpj3CqBx5/40rF9tRsAHf+vxkMf56XHAoyuCaWLn4r6KESh7NuxntInkvb4pIeNhcPNdr0fOUV0Db709g2N6iKkNLMeKBoF/pfubSIikXzX9H/k5cOIjGUI2SrLTlN/lZbBfnvDuKYNeTv1WDDdz8FfnNSBzOuDcig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784733270; c=relaxed/relaxed;
	bh=iIC+L9SRUgouwms6wXkTg2Wb9d2ocgYi1ZK4mto5XS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+G+/CZ/wco3VRDYavHSi0TAbOz1fq5alwZKhBVeCzLDpxfKUTwH6YVjqZBoE4sou/ilfHrywNuSry716JbP/2173eYnxW8eSUTp22GP04DjzoXLG2xFUPGzHNlmpuzddsCl9Ud7y3j84ddkwWXnLoPejbEHTO0yIfojiBY6vo4O53lnMS4+SFKtKHbBwQD2RsCaaxbT2Uqu0ObACltBKtinU6O4qdu05UDZ9WY8CIsahwXRHQAyRGOP4k8cdkjXsxuVD8A3ECdi5AUas7FfpgA13/FBJUD7RDu5WDKcQkpeO87jFWHeDFZfjrVYb4qgTF0Sqqhorg/8iwxgeeHs1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NpqzSh4Y; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=NpqzSh4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4yTc31yVz2yFK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 01:14:27 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so11164666f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784733263; x=1785338063; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIC+L9SRUgouwms6wXkTg2Wb9d2ocgYi1ZK4mto5XS0=;
        b=NpqzSh4YE+Ut9Wnu08LJfL9wV5CLDQuovZiAglFyWsvVB1XR/9Fi0mbKDorSY29j2y
         5uQIfJPoDDdXBGMDSmeJzfxN8llqhRR+7EzcfE7fkSOSOmiKWiyLbbvM2fI5ClVksw8u
         JDBjzMN8Pf5TqBQHDZopnitk0tmAdflfMz1ZbbsiFBAanHuNyPYoWHBm/R1e2H/JZE4d
         rf+E211IoGrXtVj1gSQ1kSCDbYXmp12G7TWhbmVZD8wCFYJdCez4JwuI19hqBUe+qGXJ
         k7ZDYSEcZRjwgu0ZvElq5dXDYvu7xZ/fATpd5P3sxopVZd0gDEva2UJM+OMazxLAg8oH
         rRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733263; x=1785338063;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iIC+L9SRUgouwms6wXkTg2Wb9d2ocgYi1ZK4mto5XS0=;
        b=hxFhVXlrzXryRq07yukEd4+3akUGEjBskPwl+OBNJjR6Fvi1sKD6KO5SvXjkPLaXas
         7TdJzcpTmP/26pHQDbe33lhtc9flMHjWVy714dKiZrc/YowF/U5RNrbUkibuS34efhhw
         JqIo3fhRJXMpnW3ySoArBIwd5Q7nSs9IKuYBhxZ3yIK+zEOpJKoDrm2THnwA/DUC7XjT
         oLPpq/0jCqwZZA0Z9sDEskUjavQoYb+t6zrOyAPSeKnWgQJOG45jCJQ5uWdZ5ySQfQEZ
         PEx0eQv+Iw6y/A50Vu2lCtvxP5MaG7EM2mgMjlbVW4agNyKs15gxFN/VhOslIF3o0628
         YaiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTzK31QErb9uV6szS1DHoFmJJvvztKwCeGVNVaxVN9Iv8/6fTdT49u0l/PiHHKK30v+8+WcIAbdJ/453o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzhcQYwjPis5En0C0yPKJvDF0eGpk3zZAV+O9IskMePinyt4+2
	g4l9aUG7mN5CQ53WsPFoHUl/Rsi9ziuPQ1/Rm1Ah+boDVkf7/CB9JEuT0WAPwP/INeY=
X-Gm-Gg: AR+sD12tgjEy9LCrQSGctqPCuZbV4BhXeP/+3bsHM9LWq8hIUjkbQ7Fkvvwotr0Zwl+
	tnc8wrc4PTfGCJ618fooyzTww6Ad1vh2tNBQYjWtDPVX4K0X0dIknmv2DiSjsiwd00e+1tE507A
	nLVArwCjBm70AY1fvaT9mmGp4cO97cfTYwPBbI/IOhUflzrU0TFp6YT8wFX3YwI9Eh+suE52XNG
	HoeMNKTzWs1z9zirnBvKxduU7fVjSLqxzXOVESl40ozqfP3SzziS2flmQnDtbqy3MHlVQNIvuTd
	j5nilWtMXnhClVK2K8UpWHQoDNMhYN+t59VaSXia+Qnf47gY0tPrtE3VcbN807birVrzoavPV55
	kdJ/YDcgT8e918jLLN2Q4fk/Py/hHRc5xL7haZgNpZh3vBavaHjb+wdqOLHVhvPO5mp7O/ht+cu
	ny6/1NW+lk7nfkMbNX4uxksqwAs/fAql5RheHH3M0u7FtD7r4vE5gRTrZW9OlrvNkYZN3re+eQD
	5qkbyTVmvXXmJMvnA==
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4954a3ed426mr259964805e9.10.1784733263489;
        Wed, 22 Jul 2026 08:14:23 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a500dbfsm70595615e9.6.2026.07.22.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:14:23 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corey@minyard.net,
	devicetree@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v2 0/2] soc: aspeed: ipmi: add KCS Channel 4 over PCIe
Date: Wed, 22 Jul 2026 15:11:56 +0000
Message-ID: <cover.1784732161.git.gregoire.layet@9elements.com>
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

The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
interface on channel 4. This is a fully KCS-compatible interface
that is exposed over PCIe.

Add pcie_kcs4 to existing LPC bus in aspeed-g6.dtsi.
Modify kcs_bmc_aspeed driver to detect the PCIe over LPC channel.

In the driver, this PCIe over LPC channel will be detected as Channel 5.
In the datasheet this is defined as Channel 4 over PCIe.

The Channel 4 name is still referenced in the offsets macros.

The host need a driver to activate the MSI interrupts with the PCIe BMC
Device.

Tests:
With the patch [2] adding PCIe BMC device for Virtual UART, the MSI
interrupts are correctly setups. The Host driver is build and side
loaded on the host. The ipmi_si driver on the host is loaded manually
with the KCS address given by hand. 'ipmitool mc info' is run to confirm
it's working.

Tested on : Asus IPMI Expansion Card, AST2600.
```
# insmod aspeed-host-bmc-dev.ko
# lspci -vvv -d 1a03:2402
02:01.0 Unassigned class [ff00]: ASPEED Technology, Inc. Device 2402
	Subsystem: ASPEED Technology, Inc. Device 2402
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 154
	IOMMU group: 12
	Region 0: Memory at 82080000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 82040000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=32/32 Maskable- 64bit+
		Address: 00000000fee00818  Data: 0000
	Kernel driver in use: aspeed-host-bmc-dev

# modprobe ipmi_si type=kcs addrs=0x82040E88 regspacings=4 regsizes=1 regshifts=0

# ipmitool mc info
Device ID                 : 32
Device Revision           : 1
Firmware Revision         : 26.04
IPMI Version              : 2.0
Manufacturer ID           : 2623
Manufacturer Name         : ASUSTek Computer Inc.
...
```

The original patch [1] review set to use the existing LPC bus and
modify the kcs_bmc_aspeed driver.

[1] https://lore.kernel.org/linux-aspeed/de49f2032f5b1f170161dcd6191c0daa48f0b0c2.1784117715.git.gregoire.layet@9elements.com/
[2] https://lore.kernel.org/linux-aspeed/51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com/

Grégoire Layet (2):
  ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over PCIe
  ARM: dts: aspeed-g6: add pcie-kcs4

 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  7 +++++
 drivers/char/ipmi/kcs_bmc_aspeed.c      | 39 +++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)


base-commit: 03f906d8f5541e8bb741035981304feceed5993d
--
2.54.0

