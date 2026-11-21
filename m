Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9E606A33F
	for <linux-aspeed@archiver.kernel.org>; Sat, 21 Nov 2026 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgoll3Ub
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWdKx4jhNz2xmh;
	Sat, 21 Nov 2026 14:41:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795232501;
	cv=none; b=deN6KRrVv91AN8kz6HU4TaneFZbLZph4b8IYstFAY305G6NppuRGIjqMvUkP1swz2Zn9TyaDLls8Af8U9W7M5nm6jxqsjqnUhDVu2Zbz1MHznCYv0JIGGNhMcV3WwJCI/b9seSqJpu+67PirhsL2F8QrPO/9n9q5wWS7WEe6qU7P/RkKTcgjLyYfp0hswDFBqmmoVEP79B6Cw9G/bXjZrcNMN2re6Hn6P3mV3ZMzJQ5bFSPSP1hzl6VfxkCq79Hk0VfW7SToMQAvDD2gmYp8sFEEWwKn3n8gtFkje9w6Vq8N4pqGESrk32X/pGMaDQqfeuijN87u38JhWtk0qd0IqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795232501; c=relaxed/relaxed;
	bh=Ah3lmmwTO4kTFu9w/FRtwILA0EF2N9TZsivGOFrxvGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLpT8rIc9VrNAw9rsr1wryFr+H40GK3Bodzv5gXW5p1Y3LmJx4exCX/WBVlP/+ApwhfPYxJs8WTlUlaQc3FN3n8wTcbA/K96I497qjc2wyd8NUd8/tJyMnYy3gmTDGpXt9Q7ODCTx0k2L8Dwb5uIPYtY4+yVJRbDobcCk7SKLHAPvTr6o3G1id1BEAQt8dACswl5djzibfsbc6MPH+fYYoFRMar6owuyH23znyiNwej9qQLA7TK6DQPQLzEwwjOEISmdVX00aIlefGAl3KSBKiW3VDgW/qwFU6KH0Kg/iatXynNnSOfrLd28JmbBIHHg4dZazklR+KWxFV16vyZkvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgoll3Ub; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgoll3Ub;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWdKx08Nrz2xLt
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 14:41:40 +1100 (AEDT)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-15dd124bbe7so3483079c88.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 19:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795232499; x=1795837299; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ah3lmmwTO4kTFu9w/FRtwILA0EF2N9TZsivGOFrxvGE=;
        b=tgoll3UbUOw8IT8SHKEbADUCm6w6hxnv2zbviHNU8djNdvVfaoQBJs54dcP/yxI3Ow
         IOvrtX+XnOUMy9pSqqxe95b9JSgWP/LWg8G2R6gRM0xq3bPRg8p25c2uKdVMNIkWY0eS
         NZ+pqr3Orx0paFsovpHqtwCndtAdh37rGfWKd3miiVT0bwisYeq7fx0Pn/NtOdivJdDs
         SbacEkP5DC5rFM2LpPj2eu1SlRc0qYIviFK3twjqgd8u2c+7dPj8+imjvRv6QrmVd57S
         dRtNfXaBbuZBpfdxMmbQRKg779fvbPVYkyWm4rvCK0qBm2Ivq9FIktBuI8XehnQTQef3
         nbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795232499; x=1795837299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ah3lmmwTO4kTFu9w/FRtwILA0EF2N9TZsivGOFrxvGE=;
        b=FAf+kMC0IVlt7cx7SkzV/Z2ELwDRjgo4024WYCwgLFmydyS8jj1VuIjyGzkMG7UxUK
         XtN9Xk64YuBaL218QHTIjYuqTyTD73mGJJ/9vqgc8z1nWS3m2J8fiOJZdUR9Wm1yO1pH
         QelqLOvjwccrfBcY1uSHeAwYhbyKSEb800xfPRgqfo+bE6nXT2pMySC1qR1n9lONfwQ3
         XacPNQejbVde265hNy+rNQ7ypyH9Q+AinOD2CP+N/nA71JSndSuRsR1Ir2d7jwIAPEAl
         yMGJkVjA7FOru2xFhxDsCOmeMXjc9eAUsZ5yE5xORONGDROMy7QHZmlAV0diWoApYmyf
         FjCw==
X-Forwarded-Encrypted: i=1; AL+hErFUWNWs8ndJYz3j4lvb0xv2BSg/DuR4xr+aFct9INFb57sBmE/cx99ubbCHQtKIYG6XKSYIQJa6g/1B5qU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/4iUsUJ8gwAXgMRo5xhURqo0bxgWjaIu9lx2RVsDrmigSJ+Yfy
	5jSaeiGdrRDwv3QhskG9nDu1Y1oXvxzQBvlIklSn8aej7SrJLfvi0aHb
X-Gm-Gg: AZFdTZdi0sditlfdCl7gGoDY5FRZQVc/AkuTxRSfLHMMyZkduIsbTFQvO60cWQsrdDz
	Bi2kJm05chRxSZ9ylGYas295UQfxHihhb5lkcw2RylKMitG2zlsEhDI/By51YlogIBU/GtbLIJe
	hKFc86Eibjb5fVqFmnb9nnNxF/eFBhFUKnVLPD17LLcIzsuKFFww2EPoSn0tQhjJ1FSBpEfa37c
	bZybzBETU0Aim4kClo3sV9QEs7MRxJi4EaKVZjFj9lca+9BckoRterfdh/ki5VgHKrTS8tMjlut
	EE7uxUEON41urkshODMHpVxtGeLREDSZOvETFUyB+Tzew2G6orPtHJA5cQP9blVw8qopFplgxXD
	nUd0B3dcY+3w/SygYe8+RICrZlHkQLCMxITit3QaGUKWsh1wnTbbt8wGPKFVYge2GL3dRBZU94M
	B0Y/JuoXszfQYGpbsXnyXSK9Aw/st9297aTZFVtPSRfRXjt4/yLvIO9bXphHOqCGfHysiUja44w
	kCaQkj81+CNw0rEBeFptMRvmRDnkzR2yz6yqWpVA+cKMZ5ywVPjXUwKlxwf8w1iQQXw+VodGIn1
	DHp0a7YetetaJRfVxGGJzjvAYkEzAmBeZPdsIclL/dLGBg==
X-Received: by 2002:a05:7300:2209:b0:386:8d2:929b with SMTP id 5a478bee46e88-38608d2945emr5305042eec.23.1795232498643;
        Fri, 20 Nov 2026 19:41:38 -0800 (PST)
Received: from debian.prasanth ([103.177.82.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm20891464eec.3.2026.11.20.19.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 19:41:38 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: srini@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	neal_liu@aspeedtech.com,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: sbc: Describe OTP NVMEM provider
Date: Sat, 21 Nov 2026 09:10:52 +0530
Message-ID: <20261121034053.39878-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121034053.39878-1-prasanth.padarthi10@gmail.com>
References: <20261121034053.39878-1-prasanth.padarthi10@gmail.com>
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


