Return-Path: <linux-aspeed+bounces-3281-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35AAD25036
	for <linux-aspeed@archiver.kernel.org>; Sun, 11 Jan 2026 23:16:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqBG16v8gz2yl2;
	Mon, 12 Jan 2026 10:16:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768162335;
	cv=none; b=GPbQlSDk6YyIEDmuFYwyotYOUPcnbRb7CCGg2UUcoWTm8cs0xVM8fU9z/6pcITQuA6hiIDGefBvSM2f2nKngCPef1PMZMJzG8rjhTpsoLCojqXofcxrfeKJNUSA5u58PQUCgT6sGZmOvrrJV+PCJ+wPtNsJzR0dIJnx2m7JVGS4Omd8r9odnEPjc+XqvcUZrO4NAxKlQgcykC23nPXWS/bs1hQ2CBfRXTaAIQSlYmnKVRScK+Tt7PwAJL9FTOtaKeG8636+btzRIosMsaLMM6t8oG4DNV3Bh3DtsZiLkDfDHuZaLLG+tfchll0XfwAnewSw+pFuoLfUSL4PY3g8o4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768162335; c=relaxed/relaxed;
	bh=sdyxAu691jD1kvoqPQKsR7a/fu/KpW6Tk0Vc+m/gVjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3NUN6o0SCs4o8H7t+Ne9AnbyV7swVN71NPp4ZoEyzAp32pfaxXMkVleqODOaEAchHaoNRrw4Jd75rlS3tAfdCbaxnf5xKgK6Zs9Cl/6m4Kdz7MBAI4sOg/Wz0TOaL9K93aauusWf3DARyUP7OnOyEw5fwjF1Ny01qGNZjVS89BIBPfEr/9aBD5sngtyRqTNXFOc4thWc76pjOEN6sODVjax4tR5OZ7IdF7Hm5N7MXBG+gGGDenY5OVicfn5TU6zdZFawXeCKdt0wnz5gnxdwIFkq/rWqkeCSCI1UvvpqiToPNfvURo6BGmkzx+gMlvFfGb/ViqPR69iHRM5F+23SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ns0Sm/Nc; dkim-atps=neutral; spf=pass (client-ip=209.85.128.176; helo=mail-yw1-f176.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ns0Sm/Nc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.128.176; helo=mail-yw1-f176.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dq69q1rwrz2yKp
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 07:12:15 +1100 (AEDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-792768a0cd3so8095977b3.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768162272; x=1768767072; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdyxAu691jD1kvoqPQKsR7a/fu/KpW6Tk0Vc+m/gVjo=;
        b=Ns0Sm/NcMrHNgLdCRJDKqCsauK9b7mU7vXfDHVpNeLJESZLRr69Z2ET5jRr0h3ac5E
         rI7rFsH/+lJEDo7xbwvARVOftrzxssRVDmILjLuteStm1+cFWqgMMFSQ0DalVnzw0ivg
         Gb92eXCSiZthpDFvYgUNe1DNXifSjXHVqqkh8JShNBtZCujAoPhOfcgr7+PNAvKeLV1E
         AEjINHS4sEic9rRdEyEPTJu91UaUUjk6gxZi9y7sE5WZjtSOtewDB0g1qJkVWiX+fIoy
         eXy3sco1mgh+9pxUr5uu5KW857Ma39zKgqcA81a41uU4RQtF3/JGIRxDMINT3G/tBN9/
         qVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768162272; x=1768767072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdyxAu691jD1kvoqPQKsR7a/fu/KpW6Tk0Vc+m/gVjo=;
        b=rmKQ9ApXzYQC7wCRhxIun+H3EInuu9NvoFRJ9tomBjnl5dX7FySixK57AGoj4v4QUc
         JzSfxX2Ioz6j7jxq0Q4Dusr9DVX8icg5NCIOZzKqtNP9hsh7FwZQjQGeUgqw3CAtguAQ
         0K0b0pkGrL0k05mQ07GWGI86Y1gw1TE4sWh3l9+/XdT++TjK0cP0MrAqEv3k3fPji1qk
         wAcEAulyjDKuixnrGLWHXblo4zsyyV6wJcqMbJZ/aGWA/lnFEeBKglWkpQU0hD7jQbu/
         vjJh7tgKON9DTLj+N82ezW19jf3lOgkzi/JAmLNljrhMujywzRi1R6IjXcHWParq1QsG
         goKA==
X-Forwarded-Encrypted: i=1; AJvYcCWvbs9u6KxEeHl9NPQu1qyZ8LddFrW1JkhFsO5iZ03sOiKTKNmafsHorLomIeJhhg+br9DgAXvZz+OXfJw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPdmXtWA7iw/8HE5+8iahZlAPxoyuqhD5FiNCkR7wV/3YOmUIm
	PpNasbt9dxOGT/5v1lDAAfpzyOKJg5+VtBGO/2LwSqQqkLvHqdrGXPht
X-Gm-Gg: AY/fxX7T13vPsi5Y68r8Qv83VJtDl45LhV3sDtJN+WyKV0FnQgcjtUYSnN71PogVAJX
	n0zDage/A6ZhHnnW9qKKS/G2r/Edo+XaV/YCkN+pbQUyh7slb1vsKNvgqwqFlNg6vyLJA8+jUfl
	f+TIaAkJ/xlO+vyDmBctKLpMDFuHk3Ns56+yoDeRvwo1lJkcLTSEU8kJUbIsgL2iPXsUHUmVH0E
	pKzX4DnZ3poo5tjBB4l8tWy+lWpULDAQSSH9+vs3534/DKKtzCTbEXiHjqT5vwqIhrDujAb5ty3
	wnndrprBwtBoS0dxZW1SpNvuB66P6B1D9Ga51D3ZSNl5m3MiadomNZu0UNsvA+We6Lgp38pBXsn
	iS1R/xt3WGx8caiGl/FgfwfB9pRuHTe8S0OU/lyMtrvsx70LTvaeTe8sKICRt1Pd53YfQq/W5WW
	gDNd0=
X-Google-Smtp-Source: AGHT+IGVAB5q8HU2wtzxDRFZ3iMEB5WzUGkbRPUYd3TtEmDhVLbDaRWN+ylZy9BkeQF2W7TNcR8BSw==
X-Received: by 2002:a05:690e:bcd:b0:63f:aef7:d01b with SMTP id 956f58d0204a3-64716b33bbcmr13406535d50.8.1768162272397;
        Sun, 11 Jan 2026 12:11:12 -0800 (PST)
Received: from toolbx ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-790aa5762f6sm62175717b3.15.2026.01.11.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:11:12 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: anirudhsriniv@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asus IPMI card
Date: Sun, 11 Jan 2026 14:10:31 -0600
Message-ID: <20260111201040.162880-2-anirudhsriniv@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111201040.162880-1-anirudhsriniv@gmail.com>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
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

Document the new comptaibles for Asus IPMI card

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..b2d20341f8eb 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,ipmi-card-bmc
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
-- 
2.52.0


