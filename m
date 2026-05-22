Return-Path: <linux-aspeed+bounces-4122-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE5FCD5BB8
	for <linux-aspeed@archiver.kernel.org>; Sat, 23 May 2026 01:49:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMlSf4hlqz2yH5;
	Sat, 23 May 2026 11:49:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779444465;
	cv=none; b=b3IAd0gA2eqV6FaIhO2W8jgo0xthNfbTjuqqnq3vgWJ1yN+z3uXQa4FRCmC6At08+bcu9RJdb72W2rDAWcP3oUQqM6QkGCZMThT8/JVegqho/4K1LIX5hCBV6CAC9PT/dVxn3bw/NYitW+GmHKO6BmOUfuHFcpj07p6n+H6SdWoVdbz9sRmppKmcXVfz5sSS2fYOsa54ldB0qrL1g0mwxD/517EQOHta1HGS3QyatX63CZOVT55lktUaJIele2/KytJA73yjcQWZV7B+Ro/uFqAT8YvK5vMYNqmGiRJ87M4GqosWxEV/SmkCzfhpA3E6M92W/U8lLUhYOuZ29d0x9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779444465; c=relaxed/relaxed;
	bh=tej9iGmEeYL0OIyPsT8v8gtxkPYs+lwa2cRb16j1/fA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iorc6eHlN9PbEi5yKZ8xdEXiP/LG+81PFKxZumkIISqW+HasX1LLlRHok42/f2Dojg6JDsDZ+d0GvgMJbfAldYeflmFesshlxhFkfuZav73q3/NOP3iuOrKFRKYws5FDz8arGr7JON++2a367mK4KCd+M+JTrfHfRnovNEGBJ7kgopAXNuRnEKVo4D8lJMq0kZHNt9J9X1aB5PYU0DOMzEEPwzzFPTqUvFb43KfC+G/llSI967k1xcWHgh+rsS7ym1Gqcdx3V48F6dcFdraUMr5fDg1iP8/VKhpxKhVkbZMXutqSnbbb1FKsoUaX/QqyjYILgF176Y0lYj5VzbDU9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D1VkISLm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D1VkISLm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLYq5GMCz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 20:07:42 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ba856db1c0so52170195ad.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779444460; x=1780049260; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tej9iGmEeYL0OIyPsT8v8gtxkPYs+lwa2cRb16j1/fA=;
        b=D1VkISLmKKUXSESOq2FZoNZC5MG1F2gfSzoH5Esk7nnqgkGRsYkWBhhIwq6rVsKFtg
         d5iLzWTQOvEdG1fyRBFk9ttHNqrBUijKH6BM8H8LXYejj70zsoN+jjMB0GVyEin0BiRK
         XM6TTN1VcJobFGQPlzkcN159S2oJVxgnh0VLHp7FQWrDus0SzE4tV9lVSeiSCrfXAjq2
         YDve8ajhekVUay+PsdOJI8PJAf9ugiN9/5T820uGhNSMkNCTyjeA0EbQVSxp+8TZBVP6
         YPrTAFT8tAntlEX6yPpi8av1FuWBSXxNU/Iu1GQE1kKlUDAX3pDByszL/wHJvfQtcDqC
         eG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444460; x=1780049260;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tej9iGmEeYL0OIyPsT8v8gtxkPYs+lwa2cRb16j1/fA=;
        b=NYgJ+3sZnPRg430qGll3q1hSS5X53IQIp0E4N8GlEJnOLs5l15jATuQD53kZzOMVdb
         eJL+XZpeq9sv6X0I0OMP5lAXYsAI6rE9pO+FbFq+HG56liHYAnTcq8aIo4fbuPfEf/rt
         NEbnDxtQZmWZkZkY2ndmdWWp27LhhrNJsNu2wSr9ZiVlwPP+TtJSnGT2cCORU2guhSZO
         IS6DvhJpwhBY4xZVFPIrc9dUPP0ect/75qXwfk5E/WiMC9UeVSf7XRzot5xulivtoCL3
         5N+9XZO5f/1I+oH65bEe0uO6tzXGajs/V5EeiM+MJhenWySjgYu7bXAnN9uKrtr+FGPJ
         t2gg==
X-Forwarded-Encrypted: i=1; AFNElJ9FOmePlMREF1HqLtzbZ/W/kIMZ4BzKYzLFuLoDNhyJlcZbLzc7i7/Urc3FgWKY/uMsfoCnfrB0Ld9Y4G4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzrsw4NKll/HPmW7zMK17HJ5la/9egJzo5y6gCqjZzfZZOuiA4z
	tH+zJL0jGaGuXW034IvkcyC7UVIgLwMgHwbUGVRl8xsYI+yaHuDwUonq
X-Gm-Gg: Acq92OH7dk8bs9kKm1aaHn4WTQ9zmpjOhBQAHetorv181DGZVJPA3tU87tp1a5i9UM7
	MrswNdr736QEJkbAk19CdPISCWxZbfCBcsSntDGQ6b6J5cdqVpbgPkviDRjwV3hKyPfVGVB4flR
	nbueclLuNvhoMeEyzoBlzGbWMqpfQkRLpvcTeDvK0pWzugx1imdYN+B8EegbtXkhBXmCKd9YwO2
	RJeZGuOY6zlLZdkGerWd4dH8R9b2QFVhN5mafHe2lGV5bHk62UQ5+nIpMVmHzJxB6Uq1ISLnPoq
	wWcqEXQv6n9aPPoLU32SH3XCGVjz6u1tt3h/aPaM69r3x1ANSOlZVjuQ4u1SbONz6B4t7XEYWjn
	wzjn+HXn8C2kkyaGMO40zSOeyKZu49fdWqqH6CoEylKh+SZCGovjXtW/xkKnurf8O6WOlzp4zVI
	P+oCwShagdl2V0+OELJHrykLOy0vkxlvKZoxepLLUzmHrAfAvUiXLfPH/wHUr5C1NlHmc=
X-Received: by 2002:a17:902:da83:b0:2b9:ff02:a14d with SMTP id d9443c01a7336-2beb06a5ebdmr30510285ad.18.1779444460119;
        Fri, 22 May 2026 03:07:40 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ca7fcsm12578965ad.27.2026.05.22.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:07:39 -0700 (PDT)
From: Mike Hsieh <mike.quanta.115@gmail.com>
Date: Fri, 22 May 2026 18:07:59 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: Remove IOB NIC TMP421 nodes
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
Message-Id: <20260522-clemente-dts-remove-iob-nic-tmp421-v1-1-ee2509a71502@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP4qEGoC/x2NwQqDMBAFf0X23AWzWKv9leJBk9e60CSSBBHEf
 2/ocWCYOSkjKTI9m5MSds0aQwVza8iuc/iA1VUmaaVv7yJsv/AIBexK5gQf96rEhYNaLn7rxPA
 wiphlHnvnHlRDW8Jbj//kNV3XDx3uQYl0AAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Mike Hsieh <mike_hsieh@quantatw.com>, 
 Mike Hsieh <mike.quanta.115@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444505; l=2434;
 i=mike.quanta.115@gmail.com; s=20260522; h=from:subject:message-id;
 bh=wtlP5mDXTH5K/7QxsvRUAfm1OYc62utepzzfVM0/B50=;
 b=KLgj3/Kt/F4ZL7TX8xSgNpcSgNFF5ozk+usyLONCgjiPTj8WwcI44UHldShUeFupva5JOA4mc
 aO2epW3mC0lBf/O70Ti3tjy+UUJ7hC8IXmOe9+Kts9QgvR2Hyd6G8Bl
X-Developer-Key: i=mike.quanta.115@gmail.com; a=ed25519;
 pk=DRIErV0xX0KMBlR/irAsbuN4L3egitHbC8FHruUH4HE=

Remove the TMP421 sensor entry from the DTS, as it is no longer the
primary telemetry source.

Accessing the CX8 NIC via I2C while it is powered off causes voltage
leakage on the bus, leading to EEPROM corruption on shared I2C devices.
Removing this node prevents the BMC from initiating traffic to the NIC
during initialization, protecting the integrity of the shared bus.

Signed-off-by: Mike Hsieh <mike.quanta.115@gmail.com>
---
Remove the TMP421 sensor entry from the DTS, as it is no longer the
primary telemetry source.

Accessing the CX8 NIC via I2C while it is powered off causes voltage
leakage on the bus, leading to EEPROM corruption on shared I2C devices.
Removing this node prevents the BMC from initiating traffic to the NIC
during initialization, protecting the integrity of the shared bus.
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 2aff21442f11..820d39a92974 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -443,11 +443,6 @@ i2c0mux2ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			// IOB0 NIC0 TEMP
-			temperature-sensor@1f {
-				compatible = "ti,tmp421";
-				reg = <0x1f>;
-			};
 		};
 
 		i2c0mux2ch1: i2c@1 {
@@ -466,11 +461,6 @@ i2c0mux2ch3: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
-			// IOB0 NIC1 TEMP
-			temperature-sensor@1f {
-				compatible = "ti,tmp421";
-				reg = <0x1f>;
-			};
 		};
 	};
 
@@ -637,11 +627,6 @@ i2c0mux5ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			// IOB1 NIC0 TEMP
-			temperature-sensor@1f {
-				compatible = "ti,tmp421";
-				reg = <0x1f>;
-			};
 		};
 
 		i2c0mux5ch1: i2c@1 {
@@ -666,11 +651,6 @@ i2c0mux5ch3: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
-			// IOB1 NIC1 TEMP
-			temperature-sensor@1f {
-				compatible = "ti,tmp421";
-				reg = <0x1f>;
-			};
 		};
 	};
 };

---
base-commit: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
change-id: 20260522-clemente-dts-remove-iob-nic-tmp421-89221ba96dd7

Best regards,
-- 
Mike Hsieh <mike.quanta.115@gmail.com>


