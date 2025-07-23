Return-Path: <linux-aspeed+bounces-1801-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31872C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVjy6bfBz3bkL;
	Thu, 24 Jul 2025 09:30:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313430;
	cv=none; b=N93gBlJmnfYPEYb1VsIJ4EZQPe24LcENGEPs2ZRGa5VH1MhDAA2qYPOqHHYbe14t/v2V97GRwumroFFWz67+v3kBMG4fACPKLMmHArmuSTrlrXx/47hGhZ+OtjkQ/V1s33u8rlLXvtOyOg+5yIxQcFUPluufXjq6mL8eD42bGezyhj600Ml/8pobDLYVti055dNhNj1yNtkKFiliLZUvEC3Mdbin7yolZRfsduwsdwWQ6QkVrXDUaCS1rSCu0BeCjvvY06UC4YiYviWkOKgoOLMputjeMqaQDA8mkicYNdSOvozgZnW2k2u7VEyx9AwpKHlXum6IuCbJl7OalE12JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313430; c=relaxed/relaxed;
	bh=b72NISK5krV+0Jl86vAJ9RGRsu+nUqF+WjMxoexuWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiLcfRY/ZWCekNBbjz9fIP6iZnIsNxHU3qccTpRLNq8cdOIMTDpwgFyz2rSBijoEZd9qtyvJOAJzwIp+Tq/n6pmjEhS1kcrFAl2wMBQM/qg4dknBB/iE9YEXDFxjNNx1JUNYyNkUVC514d1YpbugZbPFxphVunaBLMEgj9Wd52UctsU5e9Yw8DYc1UmwJVhgAtoieUlFBjESbWVjnlisg0/rqzhHhETzc8TftyM6aEjmRlSZ9c2VWJnGrvQruS9a0+0btGWndFp2ij4JfHFVaZGE3SioHMoQEjuHdwQpRAMiTeAVhv8qtEhw20Q5rXbj0xdWyF8UHrcVdUaKYnrLyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=av8rwitA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=av8rwitA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVjy1Zq5z2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:30 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2350fc2591dso5154575ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313428; x=1753918228; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b72NISK5krV+0Jl86vAJ9RGRsu+nUqF+WjMxoexuWM4=;
        b=av8rwitApLF3uyyRPEllFULfkoPWxFnhqF3N4BSwv/hhatk1o+ie1D+NMwf6wsqtjr
         NqdC35+cSb2wuDfGXeYDSGbbIS1ipbO3z7u/I5mgc47pUTZGrmm23ueKjiaeEJWAPNEX
         1zsi+8CnyOnzn2GRIjkXf1LWum2U5nHuvbF0y47gbO97vWvo3sAvpt44vccuIWjx5DRG
         8zDYCMR6Ufqx0jGZlZv0mRHem6grayysgN7gFXoGIxiKEd7W0CRvb2A2HUhgHAcDi4SK
         JHV8wicMM8S7+jyLllsepixJ7l2Ew5x121ZrfDAWllMQnVUxX+y2sRIYO9fzID+RDkKF
         Co+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313428; x=1753918228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b72NISK5krV+0Jl86vAJ9RGRsu+nUqF+WjMxoexuWM4=;
        b=CWUCSETYBiTHP/6oIR6UMPqkIj2XnTAl+BFj2AK92EOiFEjbPDPnaRRQUQ7oDT2x/L
         Tm/rtGBUQWZidwa3lR64gH0IvV0l7gIqgPDQGp8elBc7CpG3TisrlNuoIf81iQUakdrk
         3BxBsG4h9Hl+lOdB806DW46kp/Bq3EU6AIBUF1nVoLz6P5wwnbKoABGarPyvhcZld4t4
         DgEIfKFdpq/87TrRUG31raep+6V+DlMBiaPkl94K3JYhDrdmV0NHOEAtR3bQpgUjSuNA
         1IzJuGekZT1JZwWLMndGAFDJU2w956VfpxFPqUpjKgcj5XMQo6tRU8TNhWn5h/t0QIbO
         Ig4A==
X-Forwarded-Encrypted: i=1; AJvYcCW10gx45y98rh20ZCU7Ra0AN8vRPoqz9ObLs0SLwMhUZhaz3z6zMvZrKRBGrNc3l7/6Yqd/VTac3sU6At8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQcwvSH5UU/aKq87ib88aNurrhV/RpkNkdh4C5SPkiLH6DXmH3
	2vwJl7rcm2C2U7rAKA+3Aqpz1fLnU36bdtIQfC7xDRND54rlJher1bgu
X-Gm-Gg: ASbGnct6A4BKaBLCbbL5G4mkBlofBeHs/rwN6HrSiX2m8wfHLZxbyyu7VTAwGxWXDYn
	s+lN/ZfldMqTpVfdozbN2XTNvTFkoK9pS0p1mnFzl6NDHi12mpcOREpx/G6D5nwEeleYm5ojlWW
	Cx83BQJR3gtMBGGgh+Hs4H7snj/8vRODCjB5c6xhiWOW/RlVeD3BKimQqXrXVBSuddO9NJwts7F
	gdjtWqGKmeIj3qZH6ZxTnhvd9a4Z5TAEVyHxY1B3KhRd1z30EqO7mrYZLWarrmPDf9KlJWLMADR
	7dkVUEI7J2Uwc4jFGDjMVXGLh9MyoLm0LDjCCv9+xpcTX/pAYV6T/IxcBrmr+YnEtDOiZ5xKGU4
	38Hefu4f95mca46nik6MbUlqTLcvhu3z0YgqkrSd4BLXYtvIvVpWexxOGP9q3zPjzyn7q03wj1o
	w=
X-Google-Smtp-Source: AGHT+IFZkg/b8A39QrIJ5oCFTjMCG7sZ1b5Fg6PtXTUqUo1MSR5HSBvGsKpnVVU8z6juoLnGuhsccA==
X-Received: by 2002:a17:902:e54e:b0:234:1e11:95a3 with SMTP id d9443c01a7336-23f8acb17d2mr137494515ad.13.1753313428099;
        Wed, 23 Jul 2025 16:30:28 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:27 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 05/13] ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
Date: Wed, 23 Jul 2025 16:30:01 -0700
Message-ID: <20250723233013.142337-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Add facebook-bmc-flash-layout-128-data64.dts (with 64MB datastore) to be
used by Meta Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2 per Andrew's suggestion).

 .../facebook-bmc-flash-layout-128-data64.dtsi | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

diff --git a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
new file mode 100644
index 000000000000..efd92232cda2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/*
+	 * u-boot partition: 896KB.
+	 */
+	u-boot@0 {
+		reg = <0x0 0xe0000>;
+		label = "u-boot";
+	};
+
+	/*
+	 * u-boot environment variables: 64KB.
+	 */
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x10000>;
+		label = "env";
+	};
+
+	/*
+	 * image metadata partition (64KB), used by Facebook internal
+	 * tools.
+	 */
+	image-meta@f0000 {
+		reg = <0xf0000 0x10000>;
+		label = "meta";
+	};
+
+	/*
+	 * FIT image: 63 MB.
+	 */
+	fit@100000 {
+		reg = <0x100000 0x3f00000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition (64MB) is used by Facebook BMC platforms as
+	 * persistent data store.
+	 */
+	data0@4000000 {
+		reg = <0x4000000 0x4000000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0@0 {
+		reg = <0x0 0x8000000>;
+		label = "flash0";
+	};
+};
-- 
2.47.3


