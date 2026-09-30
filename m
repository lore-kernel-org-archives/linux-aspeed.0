Return-Path: <linux-aspeed+bounces-5089-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58836CA5FB1
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 11:19:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvsxr6X8fz30C9;
	Wed, 30 Sep 2026 21:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790767152;
	cv=none; b=KwGt1L6Tq0mgk/lcK4X2xNLVlbM3Kqd5N/27n/UrtzicNtkRLU/ZlhXR7MVMTBz0ujqRmHNbFVBKwGE4LPJvRve8izUfFaikGMMs78GXCH1Fhnl1EGSFIedZ2tGLahYlQ1KA2IpEpGOuDaxCvpOD1kRktWkWnx7xnuZHqp7X18TpsDNbijwGTS8h4qu7caDIdTfPZ9ru+0PRzCbNNWuSKYjIli3gWU3Z311OYdEx2cHL8t8T7+9u20bBGro2bp/OElgEKbJFMP5l5FYhKpvPtIz/5Tyu5sKN4hOrbGNISBVA49WXKAHe8FwfG/euSGx9m8PcYkWw7kMM93Av/oo8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790767152; c=relaxed/relaxed;
	bh=qvu+NvcyVJHEn3ev6yli5NPbBHtkoDtdYJwktOVlhhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy+kW8YFocbDI0/+6cSzRG1YJ0wfTkEHcbPshBvf2nBavs+5o5VSs4/14l2sQQG/M2O7ByZlC/d0iw5f4zr4Ewla8Aj8Di3UH+5CLbDVVzN2Oarj0gWwk2SzW+mw+n2EHtwPGY0xMXmzWvHLLUbCYQ+Fk/XeJ4nEdiPFuuwhS7x7inbIXnYh5wHeuvjhbTHaDd9Dhvn5c6eVDEIAv2G9O7DAy2YO9mRG5DsfaznALGoEHlloDYPpq8OwOCxTRa5YFoXqfH219+PQ96BSKMKFlNLyRDN8Rln/XRm+5atUqUPOu+YWkcl14vs2m3UgfUvH2oMfDS+sVMn5YSs780t2hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=URWG2RrZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=URWG2RrZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x29.google.com (mail-pz2-x29.google.com [IPv6:2607:f8b0:4864:3b::29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvsxr2gR4z2yjN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 21:19:12 +1000 (AEST)
Received: by mail-pz2-x29.google.com with SMTP id d2e1a72fcca58-88732460a36so265935b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767151; x=1791371951; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qvu+NvcyVJHEn3ev6yli5NPbBHtkoDtdYJwktOVlhhA=;
        b=URWG2RrZzUZgz4pfKmLKRqUj4ayUOtX607j7YwMX0XD1SwFeazJSvoemvq8iNwsYls
         Y/yE6t7rnyFY81V35vKUsW6FAtEIxKyUkkRKXY+808Wg6+k0GOlUHRS/O7SiGc/FTBQD
         cblIrmO6oawgRquMjymuZRp+Mr8Sd6ypvHaBX4fOdDiyl33kMLekWs54Sdqm5bj8Wsui
         zdRS2zUtzfr5oFA9DXhJAUY39TbeJpVWvbf/otfEmlVVqnS+39ZnBql2+2sLzzdCotPJ
         GM+iATlYe+p9SjL/YczOmr8fkHBzV+ufQpdhiHIGl5xD4eLvXs57xLfiU0+40K0NzPSE
         RL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767151; x=1791371951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qvu+NvcyVJHEn3ev6yli5NPbBHtkoDtdYJwktOVlhhA=;
        b=rC9ea0xsAuaEHuImbcg1jOo1cmw1zGe+47Z4FNO4fANnlBFbZTteydnbatEBI+6ipx
         bR4f01O7eFAm/uAEttQykvaEfv3LpHRpTHppOfzgkeOO0U/d3K6RTKAg/v7Qn79j7sT/
         4P0bx/A8PbdjsI/0wnKkBBkc/pxkbw9lSlGVlophZ9tJLoNHJV1LO4MIcSrLZgW5rOyI
         tnSgxfec9OU6afREk0wicKCGcj+VNASKQny9mSK7q2h8a+0m3ug6viSwRwWFgNOhOUSa
         71uVnWCyQrp9H9Ltaf6coc9g4lbl+t7zRrvOoBXfT493jYSBmDHf35iqPbs2c1ntP9Zh
         VjHw==
X-Forwarded-Encrypted: i=1; AKwUvBxUYQq7XZZW3hQ712wrGgAj+P5KasH1TXslUudV0SGj6UaEF98khgO3aN/H57bHjPCrHsqlQLFcn07PDPo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nuf/kAepLpjKstljHOOEHUJhXfF+v6HECUNPJ3n9KIYPSRpg0k
	k+nhGdxN9//7wWhA0qU6aZEVyY+B8h3M431kHk3DG4nFuQC9j2VdacBY
X-Gm-Gg: AYBFou0E+njLkfYYGMZhDLI952YQFWRUAGRxxtzJ/PKLZyqDpLTELkS7/OlyoHRfgpS
	/ExnUCmMISxitiCdlnMcsziEnj/ONmbdTl66FuHRE5QUFnmOZ24V28KAzTqvCOlPcWdl2GU1Ulq
	XEn4M6shMEe35vMZhOffcjhtwa1x9jUq9a4Hi5aMGstRM+mIf71ecENECvXJWGaK2ZqbQfk7rjQ
	Frx8jBvviLk5l/2cPnE1qDcDJOwweRhp9QiPdmAD0KtuOdaF7e/Ybio1yU76D0tI5LnaYLHfd1a
	EVg7oIEulmC+ulO5BxnQdkUQ7xD6CUH11h9mvtNyPMMgPLPuzhowaUA0A/lluiuYXJruzK/sbtZ
	oaeZbjbQy1O4VR0iePdw8xK7bWoG7yk6RY2EdyMNs4by1CsX/4/xMhmcK1HV6OsvfY5jk6S2FGS
	DsrO1cJuHvdO8n29aTUJpod/SFqNdkCuMEZqgEBM5f+Ud1Ru5MvKtnGUXB754wbgkldy3n/7z6K
	zt7Av4506QjhjHkI3mvYQpAHu2yjUp1RzhNlXUOOPIF
X-Received: by 2002:a05:6a00:124c:b0:874:706d:8572 with SMTP id d2e1a72fcca58-8874d979000mr800957b3a.35.1790767150679;
        Wed, 30 Sep 2026 04:19:10 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887253992a9sm650257b3a.17.2026.09.30.04.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:19:10 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v3 4/4] ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC
Date: Wed, 30 Sep 2026 19:18:13 +0800
Message-ID: <20260930111813.52396-5-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930111813.52396-1-chou.cosmo@gmail.com>
References: <20260930111813.52396-1-chou.cosmo@gmail.com>
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

Add alternative ISL1208 RTC at address 0x6f to support boards populated
with the ISL1208 instead of the primary PCF85263 at 0x51.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 1883bfb850fb..76b7117344de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -1269,6 +1269,11 @@ eeprom@56 {
 		compatible = "atmel,24c64";
 		reg = <0x56>;
 	};
+
+	rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
 };
 
 &i2c7 {
-- 
2.43.0


