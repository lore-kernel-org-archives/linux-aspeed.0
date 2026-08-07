Return-Path: <linux-aspeed+bounces-4647-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9C2C5AC7C
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:32:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcns0NVnz3c18;
	Fri, 07 Aug 2026 18:32:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091521;
	cv=none; b=TXTqxwPm67Qr480s3DzEKYSp1aZXveGkDFxU6v10607+XgJpIEkcAqkX3cgs/iTE8a9eh7APfKzklKqjrP6SCsUYl5WM9oZ5pXUmalyLZVo5y1H1zM16MHV0FHQLEVD8jNmggDgWpFKs2HwOXrgBIiSb80QoCjMZmausrEI140+kFlXgnAni6abrK13dCOMx0uGzw52615rrovYCXjY094vfiNlwPU88IQsIinope2u5/nBWRGf6qniCp+J6NyCeNRL0Xw3wPCCeOoqbYaraI/UvT23Uae35J5FvyJfYdfo+lUcYZ3bLvwclI+Ck0I/eAcwsOhOHL30Qe2nNzoc5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091521; c=relaxed/relaxed;
	bh=G+oLbfnm87lp0uiqGxHSztbOHkrNn69OeQaoJobBjdY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JApJdC7Ikst8Tf0/ADFdf6ADsw1iwds0N4CX7lwWkISUBWhhJeZ1alqdARaupCZKty/Q8cpg/v0FIlFU1TTGcvXDSYKb7merodQ9xTUL7cx+yWHhEUGk/oZdFSgkQgtjWcE9RwYls0Z6hxwRg7eNGgMePTYCMI8Wan6FbuVzuKM29WaHhN0fiE5q4auj1DsPUbLgyM6P454aFyeHMuKL7O4S4qTGLC3gDotZ62HFMucjtr+QO9z7JQDrSRVSRua5tQKWZfRoD66dhzWIpsvLg1AbBB0OY1dcFB5N7TGW6S0+TWJ6jniqKO9Xav1yz1LRA3ShWuksIseoNJzGdQB8AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MiGibg7y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MiGibg7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcnr24pKz3c13
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:32:00 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-84830c774a0so3312103b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091518; x=1786696318; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+oLbfnm87lp0uiqGxHSztbOHkrNn69OeQaoJobBjdY=;
        b=MiGibg7yMQ9yJ5SyrkF+U3zGUoubDZgyJufg191rmFfd3Sh2PBaSuIruFxNt2ruh24
         k2Wpw6FBwEtDdeo7mbJDLWD/p000ygYBkoq1Z0RvjMIscV49MhBp7MbLjX4ffcDHUmfX
         wZakCmtf6jGs62JQKlXEjliUyIOWtEZRco4Zc2+cNySNSyBlAmMNTOELf0dfAiEpHfAr
         Sc4qr35rlpl6YzVmUyCXF1L7oCNiBpyY5I1lj64eyjYKzV3/wUsKA0aoSBRqAPXAVj/I
         JzyPG8quk5KIkt+Om66hxkhvQCNhvARx58fxoqLIJqLxdrLxshLSDJSNzv2LJ9eYARpd
         CKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091518; x=1786696318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G+oLbfnm87lp0uiqGxHSztbOHkrNn69OeQaoJobBjdY=;
        b=FXMbYxMu6F9yqNrAokgKft5NxjRb2QfPj1yOnLF7DB90cq6rneSg0nPt/cPc39dQsG
         qbud2e4DSmmQV2K3a9TFiF54OFAHKdMLVxb3xofmAdENPp1odoCDxpgagQ348mUgrhMu
         O9neQ4z8eawVdTmD1aLhU4lDgJW/N0l2mhj71kR1ym4iLnFsrGzbvAdocUST+7p2EwMx
         FYXGnxj9OuReWz5ePn+eBuL2Nza5XUemZdkWkpF/N0PeCa2oZmH3GRmcR7OpnlapWVnE
         /U6Pfme9ezCvMl22gHbXAYWTbtOOMQpi2KWgLN4VBWByN3Eq9Azk7lSKnJ5qook1blhv
         qCaA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7ewsdqArW++ZHiRjEXrmSk6Mr1I4Ya8y+pe9Sc908ges+EIIhzupaECyF0e6+NEgRkTPka7cc1nbLRGg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1zorOo76ypSxV4WrOpT/9sD9W/7FWazoeNMXSnryybw1FlsVw
	xGfMfYu1qp7VES714gUGIFuwXQDtcghui2XgRQA06la8P+UymsfoKbuC
X-Gm-Gg: AR+sD12trY9YXRtO7LwvX3ttPMfvQt2ybSeU6fQySvg+IyqDL+6rxrkC4AjFd2+aZ4Q
	3cpBBbWq+yAoQX0wZaphQi65RmVibBccJPQXvE2jzRBs+Q4k6NA38l46dusjaNUzEOwnMI2Y52m
	A0ibSeZ+MrvH7mbxLLPb08RmJey82qGhkki1NjPVvTztUmFQbkzdDCXaoxpYamh/W3wX4Dk0Duz
	J1SHN8FlY/l/nL4+5HMoMN5maVo+FLHGu+602ARkt+LYs4TfLqUr8lnXzV2lwV8JW5gQorif9nr
	Xmu6+VC5GejQ4eoZYrft8dNtj5rfdIzIGVblxQrWzYeZAvYMMQNi/YaHT3+tWLmO/BULaFGVvI4
	W3dZTSsg42LoxjmQo3WDnIKrEJ/MpVBSqb8oQGIti2vaOSvKfRXqJmwSXnDe6e8ns3ejti8Zf1W
	sxZFpnS2cMRYoZoCFES+plVE8LuMFyk6/7uAXyrOOmEsCnt9F432anWUmzZ8HuDLO8dn7WCuvuR
	27nLKSi2JzzRoxlIrnWMlo5Wl8kjUioPzTidDK0jmmw+pFPcg==
X-Received: by 2002:a05:6a00:b806:b0:847:e2c7:59b6 with SMTP id d2e1a72fcca58-84f2e031181mr24296331b3a.11.1786091517957;
        Fri, 07 Aug 2026 01:31:57 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm627409b3a.43.2026.08.07.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:31:57 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] ARM: dts: aspeed: santabarbara: Disable power monitor nodes
Date: Fri,  7 Aug 2026 16:34:05 +0800
Message-ID: <20260807083415.672008-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
References: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
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

Due to a design change, this power monitor IC now has multiple
sources, and different vendors' parts require different drivers.
Disable these nodes so the kernel does not auto-probe a driver, and
let userspace instantiate the correct driver based on the part
actually populated on the board.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 2a822e38f091..04fa9a5e0d04 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -585,24 +585,28 @@ power-monitor@40 {
 				compatible = "ti,ina230";
 				reg = <0x40>;
 				shunt-resistor = <2000>;
+				status = "disabled";
 			};
 
 			power-monitor@41 {
 				compatible = "ti,ina230";
 				reg = <0x41>;
 				shunt-resistor = <2000>;
+				status = "disabled";
 			};
 
 			power-monitor@44 {
 				compatible = "ti,ina230";
 				reg = <0x44>;
 				shunt-resistor = <2000>;
+				status = "disabled";
 			};
 
 			power-monitor@45 {
 				compatible = "ti,ina230";
 				reg = <0x45>;
 				shunt-resistor = <2000>;
+				status = "disabled";
 			};
 		};
 
-- 
2.52.0


