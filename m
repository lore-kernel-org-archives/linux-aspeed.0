Return-Path: <linux-aspeed+bounces-4875-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7FBC61DE4
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 23:44:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY7xf5ySbz2y8d;
	Mon, 31 Aug 2026 09:44:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788114058;
	cv=none; b=TRACNdEW2lgnlTJBWxCZfTTPY/Mta1+bDs692KW0R40NPWCvq6vsoU344EDpmpouELpg67X27VJSQvIpscRBwNdJPS2ntsYEDtYSotC8W4l2ujMY9VAEibH7Q4cJg+c4g70GB+nzD35IrYtTsupNA9O6FoZ5KY3B4qlWEVH4Fx/HD5KzXq1o//tlkaD+WV0Apqg+tG1TxjIZtKppX2atiM9XT9mA/RS9WyK5ihx16dnWBkVdc/h8smlAAPLMWjKDVCbrtG+dU9ueOA2eRPBAHy57AHw8BP7axXCqVMP1iFy8R97UUsrOOx1jOFrbehA5UZ+fyd9N7YD/Wj1StfzL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788114058; c=relaxed/relaxed;
	bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtlG7FK4Va2g39AK5lN9MFiG702DCANgPJnGrAGs/bjQ5hjoUHPLDtMNGKNqvzzstCun5rwj770fDVGrbVtt3ExGcdQK6CW2J7SQSbnHrIND1eka1jL4fMa/cTCK6fqauyJhVbU10uDRU49VClGAltoDIMcEwdbVSSrtUg5+MYqCIACinZhS9TpBLQNUIpBM/OpWwMQzxSlBGcVWKiZxAw7zyWb5AzwX8UH+yVoZZWS8RdbwedOs8Yvn+SJcsjxqXLHJV/tlEQIL80v0IOPeZUH07Pm8tn+hbwGrzqkFTlSH/LpuVVuJsZDOE406w2hy69eT93tB3WMqGzqmmW8fKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HRHnhLMF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HRHnhLMF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY0mn2PVWz2xT6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 04:20:57 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cbee846deecso3639789a12.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 30 Aug 2026 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788114055; x=1788718855; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
        b=HRHnhLMF4Wfsn52zQMXopJu9+ECaur9w5YPCIaBrGpPvvl5xv92PFhYBj/tYHqHSem
         AeRgeIc+BMwy62KDXqT5MyTofVtAIXXnzSTnUfyoRwMKuYwauKgPyt9Zl4gusYZGeqou
         jh0IgKJlO6t6lGR7hDxfsn6g5YlYpr8Ijk89mZPN1Uqzgm06WmnCWJuzH3/tpTOV8IMM
         DYgIdnCUXu/ZQ9iWqdH1+GPIslc8Dv8BXyo5xV2ZHsV5LwtMbu+KDjjYEHbGfHcavxeR
         T/4gyp2dRUlb6wjzymsOYUkU0OI1+ykQoCOfIviJD6pnr7rOTFv5a7yW5xueP9oczE6O
         ovRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114055; x=1788718855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOdg97xUtxa8AhSsk3nKT5LmiSCoT1EL2eRC7gkp05s=;
        b=ZN+RMZ2BxWnJLyFVKpAspxQdlGqoMxxWYZcLPf8aNbbFNQ62ot5NHhuL9kpvj9dH9R
         euMUqt4bg1TVzG4TfRr+amF08GlmAxseQsdhtYKShHG+xKy83ZGw1cR8aMCE8byyQXSi
         HcUz7W5QrnJIju/eEMtC+vhyVZGJJLhfaKAM0A2IE0ZmdPRxJhPqcITSYo7QyoTu25mz
         c8JxtO+LIP78VFucKs7wRObzWn88AC8pG+YdEdbJpY0SSVRe85pMOukILZGAGdrhcjaz
         tXiNCrzZd7ign4MVC6EbUBjd9437yOcKGD2yEhQJ75mRiBhMNuCLGOrRBLjIFVgzXNwG
         RaPg==
X-Forwarded-Encrypted: i=1; AHgh+RpMuNfFAwM5rDG0Xn838eLXfmI+rDlovYUF/1oY7xnBOcCn0eft9mAcV4d5jLKjKDaxt9ZARyrPoemLQxA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nw8Z7/34LDRTnOecmQkNSDDgQLK9kKq/P00+rTPIxQWQFhNltp
	uDzgR5lvuthPvqLa/I/9yCrplFZ5MkZUONfM5eiBuMT+oQAISLTBduGQ
X-Gm-Gg: AR+sD13OGr+waOib16lILOL3WfZ8NQKJ2acZQjX9WyNZFhjuxrMHAonRrZ2ln2hMGGD
	L2HGqNfZbSzwrTxgPGXuh/mj4DhjzYO2Nce6na7DzgTkdtb6h/TvcXvIP0PQ5vpNed2gBB0QBD2
	/OVhilwgB/ElJ9/w20QuGMEVVbIC+vdvhKY4RrTNzTP6C/8WxcsTAneFwnA3pDPMzLRHTiJYAtc
	KEzQdpmG1J1/JjnqDRv0tdTEAR8/tZseunyjyn86Vy3TbKI3WCKSfR3WgRp4XMGLxAYE3r15Snf
	rMRCZTQVacD8edHodwfgBbqGb9ZSNGAHR8/qw3kek75AEOR0+CR9MHTQDdf8YjZ7mx/93Kadb4l
	zM6fMLh6Y4Tc4UcY92Jzr2WAtS1a2PbfqTXhzaY9LIi3Wu3RsfHxNayKq1kq7331OKcctsZVX46
	7gSao9nz94Ovmj1W4tbttHIZxfl4PASq6z43uv9jaCCtdapLS72WsIKLr9E9n8ebgja2o0IWFSI
	As/jA==
X-Received: by 2002:a05:6372:a80b:b0:3d3:ae50:97ce with SMTP id adf61e73a8af0-3d3ae5099d0mr18192338637.27.1788114055247;
        Sun, 30 Aug 2026 11:20:55 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a847sm21619480eec.17.2026.08.30.11.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 11:20:54 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Date: Sun, 30 Aug 2026 23:50:35 +0530
Message-ID: <20260830182036.284736-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
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

Add the compatible string for the ASRock Rack B650D4U BMC,
which is an AST2600-based server motherboard.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9ba195b8f22d..4c9e96801c1a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asrock,b650d4u-bmc
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
-- 
2.47.3


