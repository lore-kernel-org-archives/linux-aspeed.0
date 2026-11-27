Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF3606A32F
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Nov 2026 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oY2tGUQt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbJ6K2ghRz2y2h;
	Fri, 27 Nov 2026 13:59:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795748361;
	cv=none; b=fNK55KDlW6KyeZJXCu7sKBiQC4YDEECfl2Ze/e6W7IrExtQnv7jm8K9SXtaeJj62Bsn5vtp0fe4YhbZyoAS3bQxImspv3MfkmLKH9ikA16yRrYMX/xt7L6qICwrnUsPm8CtWnipd1wK3FgVf5yDbQziVjK0bgupyo672OI7Gx35OtJmh+ttf5Dl1K1rhT5iXQuPb6DFmuivxs61HBUNnOghDIrDM9sz43g2YHtDmVc2wggvSW3eO35zZso0gy51fYKts/HN7kHtqTS4ABmc0r7Y1u0Mf+ICjRntPP8fikpD2H/ZmhQ42Naw5+5ZTXpUSL4JAcQZYa1UzmNkU2/Ed7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795748361; c=relaxed/relaxed;
	bh=y5ExnJt0qck3DRDUPFaDvu8b7KIWwdeeXU4WMSYgy3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YISPOAXC9jekGTLPirSll7l5pXzzaUgjgwFgD4xuIOuSBOSbbSqxPzwvHbiXl+8t02VMZnpXkRRh7/qoloJP2v8IuyIrgYVTVpqsCyese1EXF5HmfvPOClF5Q5QyQpNuXObi9Kh7bRm+ID5+AeBnNJ0eC0njI6/be4EzEGBmxst6tI+t2qniovH/KpTbrtiGdJOdncnegEI3z0XEOFddSUOgxkio0nHhVlcLcrAB9CsqK4l6cPgNJTRbKwYzPal48qjOSuT7R6A4V3wfi5wAmO/5orge0nasWyQOCBmB8cWCnFVd02RrOMvhHi5gkH9AaVC0c86T7ZBu6i3O8hPaDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oY2tGUQt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oY2tGUQt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbJ6J4nrSz2xLs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Nov 2026 13:59:20 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-386bd881d39so8137867eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Nov 2026 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795748359; x=1796353159; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5ExnJt0qck3DRDUPFaDvu8b7KIWwdeeXU4WMSYgy3E=;
        b=oY2tGUQtsXM4KAPztroD0bnrTSzS6dH3RQlJxOp9ebhSyUjl19lJMfognFh2sNVu3z
         302sOixY6InXc2VTaGmpyqUEma6qdM7jZwgNCM6tGtvY3LYMJogyXadwdbCbMcCVXdYE
         b+tMoZcydC8y3m5N/u4yu4XBy4meM3KmIzk+X6g8O8M8m11VRRS4sIpikAHEOaePwM6W
         vuojnFlh+LgIgOY6tBnQ20I9wY3NwFYnVi1d8oKTmuEtuiFQT6KMih5bcsKN2XxQvfGf
         HB6Z0lQKh8koDtVWpPGgmLa0RsJnT5MY9n1tW/gdEvyyHs4iDnrHg1UyuzQbt40104WV
         kKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748359; x=1796353159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y5ExnJt0qck3DRDUPFaDvu8b7KIWwdeeXU4WMSYgy3E=;
        b=t7Yc0UMkf7VFw8E959Ez7C2kFRZjA+iQT+reijaPvKTheVV2A0hqbXJNvgSzNb4rqT
         +UUa1WSxUKH5lu8JDYBn9Kpql/Ci2ZgVQqJCi23M08ZUUd5QQistk6cUqMSZvDpkVNYF
         LHmW/k63ogy9im0QPNkCqwcBlzp+zgTaZcbLiIV5haZ3UtWE5wJyTcZX5FtLyNj9FaKY
         hvPx1W1K9BBdShNT7C6kAtNHPifW/Jt3Q2KSbduv4fOYn8JMxVsH0aCcMiXiR51cdyEd
         pY0rk4yOTa5pBcluB6EnEejVWsgA8hYCgT6MxIkpHIZZy2Jphp0wr+x/vyRl+NlLhT96
         NhlA==
X-Forwarded-Encrypted: i=1; AL+hErHpTPnULjjVp4XBVATgfyYhSdgMjyW3gt6wh8vRlYbQOD4O981/ddtNF7VkvMxgqKZ2HybxUX8aON1Yifw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9ubtOnbDkBlEQ5OVynk6bBtcXvKtFK6m5pbLeqTEx6ng1f3NBc
	qyZ/Km8bCHRNuj2IpFI9PWzLhddEnLcO3RiqtKMwX4I4skPUZG6bWWYH
X-Gm-Gg: AZFdTZdJFb+cIaLKcD5LtbwQAzroE0fYbfL65B+cen4AqrMqXuKfpFlsu82+3CKBfBo
	N7wEfjP3gcFKWQyT6mzwhRZg2CZzO+hWEspSF8EcyQH5JpPSbY7tvk0+tiwRHYbzu1ts7Lz+QWb
	hSs+u/UOzg7FXHtK8tTOzAYLiFjzeYm4ZbSRzgk9ckvuMziWFGhDhzkI27IM+FbJpF1ioWQLGAT
	CdRdH6/XWSpIH7wCyMzDQaF9ljlGJH8d4Wy07vOdv6QC0hiteC2tQoZbFmKyRaGoi5IAo8sWyPj
	c2nhBcr50OACrwJTCVlOf/zp6CLOp5WVBNtkE3UzYKTUvMRfQuF/UFbp3LVazogoJPjmnKYttfW
	UHfrGBcKx9swzmPBCdVLvlPT3DoMWyxzMbwEexL4Zc/1lB504fTcGcMJJyMJrPbtoUMbOWkzJm9
	ssdNn/znsIB7uXuFkTe9Hb+GRF3OXnEG+brBTSoViSPmhPUGruazkQVFDMAEvFc5xDEpes2qRgL
	GaARZ9fXFIdqLvSXGBq2ukOV96IXL1vBDCrNCnT16vVQvIUolDGUHXWKNio6prBaCykOsuzGqdH
	y7ME95U3UmyW9An6AWbqUjtmfh8EeWeYBnHPcKpOvbIWIRM=
X-Received: by 2002:a05:7300:cf1e:b0:36c:b138:651e with SMTP id 5a478bee46e88-3857093fd1cmr27144602eec.22.1795748358624;
        Thu, 26 Nov 2026 18:59:18 -0800 (PST)
Received: from debian.prasanth ([103.183.205.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm72013313eec.14.2026.11.26.18.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:59:18 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Neal Liu <neal_liu@aspeedtech.com>,
	Tan Siewert <tan.siewert@9elements.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: sbc: Describe OTP NVMEM provider
Date: Fri, 27 Nov 2026 08:28:16 +0530
Message-ID: <20261127025817.20090-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127025817.20090-1-prasanth.padarthi10@gmail.com>
References: <20261127025817.20090-1-prasanth.padarthi10@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST2600 secure boot controller also provides access to its OTP data
region. Reference the NVMEM provider schema and use unevaluatedProperties
so common NVMEM properties are accepted while unknown properties remain
rejected. Cell offsets address OTP data rather than controller registers.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
Validation: dt-doc-validate and the selected dt_binding_check target passed.
The binding target used dtschema 2026.4 with a local diagnostic lookup fix
for trailing # in schema IDs. No validation rules were disabled. Two
unrelated TI type diagnostics remain; no SBC diagnostics were emitted.
The valid example passed, and an unknown-property negative control failed
as expected.

 .../devicetree/bindings/arm/aspeed/aspeed,sbc.yaml     | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
index b8c5cac..d8e19c2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
@@ -13,7 +13,12 @@ maintainers:
 
 description: |
   The ASPEED SoCs have a register bank for interacting with the secure boot
-  controller.
+  controller. The controller also provides access to the OTP data region
+  through NVMEM. NVMEM cell offsets are byte offsets within the OTP data
+  region, not offsets within the controller register bank.
+
+allOf:
+  - $ref: /schemas/nvmem/nvmem.yaml#
 
 properties:
   compatible:
@@ -27,11 +32,12 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
     sbc: secure-boot-controller@1e6f2000 {
             compatible = "aspeed,ast2600-sbc";
             reg = <0x1e6f2000 0x1000>;
+            read-only;
     };
-- 
2.47.3


