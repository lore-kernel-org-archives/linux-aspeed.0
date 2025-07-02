Return-Path: <linux-aspeed+bounces-1612-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E218C8303C
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 05:04:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX79W51SZz2xlQ;
	Wed,  2 Jul 2025 15:04:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751432671;
	cv=none; b=BMQiPCSyr5Lu0mm2qpfEo5mv7LToVFgNw70+dpDy8BWnvbIpUvcbQm3CCwCgx1N53bY/JZPzrppWnPTNzVLBSZ/+IArSsUKhbhGDOat3bYkSE+rzaDFioMWO9DiZYeWgxn7+ZyYvn6pZIvzAjvueXCagGmsNqSn1tnaVn7NOro1OsMoLck9eXQKqmfaIy3u2fcbt9tjeuqRGnhvPxUDk0sk2OyezqYjM/gKUJiVcGO/LWc3wMme35xvZuUe7J7OnCMpyeJc09E2c2QaZHotpAnlcQeuE1NVzVfBkHN2yVPAXDitV8Hl0bFSAPd2MeWnB5MRM+Ylig+9bgarHKqJN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751432671; c=relaxed/relaxed;
	bh=uWSrZ7MoIPETCcOnlwZzNW8Pica/y+0lnik37Sdi1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2oRYUMJSrw+GKv/3785/2v31+bhz4NPaZuVlDUSf5Wed+4/DoVq8y9qme1FwRlo11B58k2IEvYZAtkiosD7lrrQg+tE6h4JzNg3t/6IQ39I9vNduq5CWAdX6Na1AWtVpflajNDNOSIieQPeub1KfKLQBQneNBKFCJ9/FKdXXPQUeVfQ8VC98pjMLU9Degz+sa/SBbuGKQbi9OgabaVyCL9AP5+2eCs7Y7kLVOebr14mH7mKDeecazEkfUj26cc1VWzNun7zBuVDbWLYSlwbhfYZ8DWUPucucCrbg1FoeegPvWOKO81xaVGM/IgcAIhL4FTyNjhiZaUyievsxn+oHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RETZlukE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RETZlukE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX79V7145z30FR
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 15:04:30 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so6235261a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Jul 2025 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751432669; x=1752037469; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWSrZ7MoIPETCcOnlwZzNW8Pica/y+0lnik37Sdi1T4=;
        b=RETZlukEguEmSZ6maS3zY5oxZAOojHfxq5GPcmhAxzQ6OUyZ+lqKsu4iFKOyAXzlmo
         M+XIdTGQWejVkLWYS1QE1PhHHEkSkYtYJJJN0WyKVi5PYIgjTF2kNDi7ziDWMldBsHkQ
         nxGSLro9MXr/Ofe2IjFl+dTbwKXY2kmMy5jHzlL5z0203CrSd4q+A1feJgJJbF40HlDF
         vIFmsgdKIjn+H4A/VBQQsTtw7WZzXOlpQhdJiW/5FCG1MRXV/3QfPGS9Xlm03jsMTcxr
         HGaSnRaaMqQChGdT31ERkXNTWHo9xuqW8bVV3cx1kVz1XwD6+ntFDNOA8YDvGTJ94jTs
         3MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432669; x=1752037469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWSrZ7MoIPETCcOnlwZzNW8Pica/y+0lnik37Sdi1T4=;
        b=Mq/COOt3mwN6IW8cydol1h8ASO1GyPXtnXFnLY2KbAbBZM9Ap7Bdd3EbGbPsyV5DRn
         ea+ebXYa91gRRfu/PqYca/GSvq6fcP0BeeC22P9m0W52LKRtgj8iwJlhp9ZwotSndhz0
         VM5bvLstpFmovF47OigM5Ebukk4fbOfAQW4noDtJ14cerYg9D3vc84+KYOczCJ4KYyB5
         OdgNy/qRcEtgJHy+eRquUAG8UDzW5ml2yyQNnkF70pXCWanycUkC/UkLzleHgHDyz2Ih
         einTPrqgvicXwavIcs7a2K5AUzcfb/b6wLHHZxdcBtKeT4dM2OcK2f3geYPoELthSsDd
         Gtvg==
X-Forwarded-Encrypted: i=1; AJvYcCWZUxZMsGalOY3L//+XM1pZN963HZeCTR9LTh6VB+uzDbss4WlobHp3Dks2tuhtdOxbeJtqtZyN6NHqzPw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2XJCmf31ng5rLiHP0DcEPImnvHyWlHBSyuHV72LeZHJuAPcFQ
	CVdYl8YgVWwI80F8N5/L0P7vMGF2yimaK+gnhbWlpGJz6fy/IZvdwZQG
X-Gm-Gg: ASbGncuMCgOTGoaBXi+0aQGNas0b10S/WN2F+9NgquX7DgS/mXwGjLhIsuxXMd14BYg
	9CH2KV0H/BvAmTW1UkhOo2AbMM4aDuWL5PSq43nhusTex2sKjBF+DAABIqwrA4dHx868ZvO5nc4
	ZJo2x/aRY82QNOm3Tokbfr2fuVtcp34zrOVMAWqmissLq0fhQ9wZlo4LcEiQ4YlDTJFROPFRGY/
	rtkJt7BpID2J1Hc9/WmRZqvQH2gb+kzG9EjqrNrVvqaO2tEJO2G4CoofRZ91n9SOcGUiGB2m3ZZ
	Abh8kYqIw50DvMkLKBjxeNrxCUT5DtjX7ph9DVOibCZwFxDaUbs3ZarsUXzzITZNBpK/QTZNJj1
	9Jrq21mOnvr+hGOcsMWxrEQMp+gx9LK7YUUsUVGM=
X-Google-Smtp-Source: AGHT+IGuJYvsdkS94RVkJwX3+DQ9VYFkHN7fl6zwMk3S0tAKLSb9AffKnRoc93xoFKLH+aUzWSJPCA==
X-Received: by 2002:a17:90b:224d:b0:311:ad7f:329f with SMTP id 98e67ed59e1d1-31a90c08804mr2307161a91.31.1751432668615;
        Tue, 01 Jul 2025 22:04:28 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm18168323a91.25.2025.07.01.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:04:28 -0700 (PDT)
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
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/5] ARM: dts: aspeed: Remove eMMC from ast2600-facebook-netbmc-common.dtsi
Date: Tue,  1 Jul 2025 22:04:13 -0700
Message-ID: <20250702050421.13729-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702050421.13729-1-rentao.bupt@gmail.com>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
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

Remove eMMC device entries from ast2600-facebook-netbmc-common.dtsi
because eMMC will be removed from future Meta/Facebook AST2600 network
OpenBMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/aspeed/ast2600-facebook-netbmc-common.dtsi   | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 00e5887c926f..83c9789d45b1 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -152,18 +152,6 @@ &vhub {
 	status = "okay";
 };
 
-&emmc_controller {
-	status = "okay";
-};
-
-&emmc {
-	status = "okay";
-
-	non-removable;
-	max-frequency = <25000000>;
-	bus-width = <4>;
-};
-
 &rtc {
 	status = "okay";
 };
-- 
2.47.1


