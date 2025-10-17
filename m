Return-Path: <linux-aspeed+bounces-2511-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952B7CCD184
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 23:44:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cpLy66FNyz3cZn;
	Sat, 18 Oct 2025 10:44:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760708784;
	cv=none; b=a0NQp02gkiR6t/Dd76drmAQWcH5qHaiG82byh30j17Hsrzihzg1fDWIPxtXktYHI8uBacQ0MF/+2HgkNv+WC2rnf/eIh0o7XHybOfCN15HJjBdf46+F7E34PY5l6a83IGpqhBluV4RA4IJU10TKkGSu9ofKgnyynel9SkY9/AUSsxQLxHpBQVvdl5RPEJcdU5eQMCdLRjqoD3yaIVEErGoWN+RmYkv0dwmlQPNwObSFl3mJA9M63sVZ+iE7DT4r0q2inAuOA9qcEbq8FekvXjpkoCpn/z6SE6cqC1L21aewQ/sQgPg01lkhw6B/7TuxY5PBSzvbX4LJBKj4OmfKYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760708784; c=relaxed/relaxed;
	bh=F8wxeZ73zfPxZDqjOffcWW0zKOqaQGOLDGU9q6V4WVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hv9W8AW1z3WSPma8X9T/Aq20QLTzYicIuc7Mf2n93nG1bPQiSAybWzLNNNmumbNBDak8OEAwObUZ5acYjmvyV5l5Osb0q7RMqFtHIbPPONJbD5+j2Q+mRLSranDqJhrm1Kkz69KrwGn5c+OAnHq31L9AgNFH7Ri77aEd7n8edKRU7jPzyZYzL55IXJaFF7MfQ0fTzC8R05EERjwWxLKeu2g2fsdx06Fz5HSoiuSsF+V9W5FNMsKrOLGrlrsdDhStS91pVjFFmMdSzihAg7gYGp5jsr9uEs3aL+gxXAPq905EeqBtHDJN374+isnwLP//gBqKKeufivnNAKBEl6cHRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hfr7GIk1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hfr7GIk1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp5hH4TW9z3cYx
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 00:46:23 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so1753849a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760708781; x=1761313581; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8wxeZ73zfPxZDqjOffcWW0zKOqaQGOLDGU9q6V4WVw=;
        b=Hfr7GIk1Fz5ut03iQhS20gk/VUN2OM0ziNh2qp9MTC1SwHwpasJngt6iYZyB19MLD7
         5n9EOOWwK+g/h/A6mbFLvhTuo4XE9g7w2vMho2l2DEWYcjbVnKtsO0HjnoFJUlP56IvT
         mSo14vvS0mTUFcwCxM8Gz6bWEyS292ZwGayNB4UuyNdqFtl6dddBSApbfzprvC/P9zq1
         7PKquNETxIAWgChQZE47whJ2KfwKHGtLOcbxKV9GeZISxBrBuQZQ4fIEfQ/UksYNwfVa
         R0nh8lYyu/lq20GKwKa/OdXqKwjUP+IAKAg8am0dsTosc0GVa2cgPReZBqOZbX0J7TMk
         tkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760708781; x=1761313581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8wxeZ73zfPxZDqjOffcWW0zKOqaQGOLDGU9q6V4WVw=;
        b=Ainh167sQCTqjKB2rNa9yb7/cEGQwog24JcPlvmR6dp/vE8X6nMqVMHE+IF8+1+UmR
         6MF35ErvIqvN0ie/cG0ZOA9WITVKjenaiP4NWQtADM5lAV38SC+57JrDMIG+TKjc7ZwM
         JO0iecEdJzre5O9ZMIGpFiv+0lyM/FDZSXDb55Bp3L30abHVkahZ51GIC0KdUgX0GHiw
         hMBQDrodMVpjch1iX9BPWbbTdbCISP5b6DvNkUHwkaPgj1TCUI21tK1SclkRgbX8mdKK
         f0U5wFjIWgkfSVXYFTueMSVxchlVbCzWmmdg/OfY2MXiKumeJWtlbr3O/l1u4K7yL1r+
         LaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKdQOvibBxDEN4UP4bF51xnOwOc1B40+3FWeUf5LtMiSKwh44YTUkqcgC2TYLygs03NBiND/UaHfQ03Cc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxjfM0Thd2UI5sEEsS1qWTRyokRJBkc7wQa1WZd7vm/D9ui0KW8
	jeBVzo/MpP3DFC43TLLuWpr1uov5JqJHnu/HK/yUYZXCLPRg2uOFQJ5C
X-Gm-Gg: ASbGncsdLeItEGDLGiZEi4x8dC25hGa/2Sk3Vd6377bB3m0lastSTgI51YVvBtFw65F
	6ZXUhfpNfzgPB2UZsfJ8FRStvMLWW2w556hqzihhsyLYOTC7aQsPolOAxC+O2pwEIi6MdSylsFz
	4P/aQO9y9RJKTvrmal9bFfA4rdvGVqNM0vff6AEDgMeWyas1IVRX72PK3hBx3zW4Ayqqd43v81P
	zxSc4NCJziKqlgbmW5A7j9qLvXXP9T3GvDTl7r101sf+pfkTdOCcCPg6zPc5/uOkWj1BERToZQI
	nYyu7VoM4LxK5lc/FoNoLei1lWbIP65T3IKbbU42vtDNF16JETJjWtJDB31ehjTHNCC5wyqogVr
	moDxbKCW5sBLT2KlvDpITQVBzvqVoKrHYaO2MjwwqCZy3fQ3J5d8PNmlNUyy6K/gTbr6T9Ou6iU
	X2U7BKLfsXmu7/UwtctzJFbJ4do+YbYmqJO0xoG/EB82D9nII5jGe7W/eV1fCnAK87EV29fywzG
	M2i+BaBVw==
X-Google-Smtp-Source: AGHT+IHEJriQOsCE072JGcgtKsQf1uKRAkkKtWjtVovvtEqRBoI600xoTijqLOXvNy4EBRqUN6GmcQ==
X-Received: by 2002:a17:903:19e5:b0:265:89c:251b with SMTP id d9443c01a7336-290caf8519dmr45137495ad.29.1760708781029;
        Fri, 17 Oct 2025 06:46:21 -0700 (PDT)
Received: from bu9-daniel.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afda1dsm64834695ad.108.2025.10.17.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:46:20 -0700 (PDT)
From: Daniel Hsu <d486250@gmail.com>
X-Google-Original-From: Daniel Hsu <Daniel-Hsu@quantatw.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Subject: [PATCH] ARM: dts: aspeed: harma: add fanboard presence sgpio
Date: Fri, 17 Oct 2025 21:44:02 +0800
Message-ID: <20251017134402.2073042-1-Daniel-Hsu@quantatw.com>
X-Mailer: git-send-email 2.43.0
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

Add the SGPIO definition for detecting fanboard presence on the Harma
platform. This allows the BMC to determine whether the fanboard is
attached.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b733efe31e8d..7983ae0bd3f3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -814,9 +814,13 @@ &sgpiom0 {
 	"irq-pvddcore1-ocp-alert","",
 	"","",
 	/*O4-O7 line 232-239*/
-	"","","","","","","","",
+	"","","","",
+	"presence-lower-fanboard1","",
+	"presence-lower-fanboard2","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"presence-upper-fanboard1","",
+	"presence-upper-fanboard2","",
+	"","","","",
 	/*P4-P7 line 248-255*/
 	"","","","","","","","";
 };
-- 
2.43.0


