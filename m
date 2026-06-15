Return-Path: <linux-aspeed+bounces-4255-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C785FCD8CA8
	for <linux-aspeed@archiver.kernel.org>; Mon, 15 Jun 2026 02:44:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdvbK21Fqz3brT;
	Mon, 15 Jun 2026 12:44:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781491469;
	cv=none; b=gnfLmuHNePhQ9IcmoM3Xq2P1zDef4lbYjorslen+V7Te5tvIl4Nx+Vs0FbXSA6M7oeLbAZkkahmirZyNGvEE7GqIKqEYIxei9JeJWOFgroc1A06lQHrrlGfmOeoK2yDps/U4CcBWGGAXTf7wtuTp6b0B6oVU64dnfM3k/qXGv6LCqozT0VZtduvdxN2fsKrZe/F+aBmbQ82zjWLBRkNlM+RH6MQ9XQXbp8mizsKUL5u7gIAne0F3wa7LOc6EcXWMyAXSdW/yB+NdTOP4AQSMIpdeM7fZ7q02Aq4OAf7QZcDp8RtKX0ihtiut9Dx+r6cUF7C9uEWkXZVu9DF6J4JFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781491469; c=relaxed/relaxed;
	bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ciHviUAWktghnYWYCMj9VmAeq+icIfz6cAvxmWi7R5o8580hadpDOF/zVW3ogrUa9ubYHsi9fLGrBZ1DhV5lpfiqnsN6SvAZn2bDCI5Dx5ahZwtF+zkPHYKc9lYMQX2wXrWe73Yh6qmNqK6ziguNaNXvGf5u2Aw5FOI01M2d35042Zn20GOOj5HdfSdZHB2+2ugxU0HxQeRT6hh0i8z6a1i71kYi2HZcksZbPevFbDSHHSg/pJssvWVOh9OhDs/HVtdJYCWVZHBUAtWRHkicp6gC6EYHdWtPqc7DETA8ystoByPYL+0sb/ffuSbowfKb50gQ6iCUBUQA/RHtQAo8Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zki+6UMQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zki+6UMQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdvbJ4WrVz2yT0
	for <linux-aspeed@lists.ozlabs.org>; Mon, 15 Jun 2026 12:44:28 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1023512a12.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 14 Jun 2026 19:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781491466; x=1782096266; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=Zki+6UMQ7WSNa8bHPlK0eAmyzRlSHKr/Tmr0mvqUkNim6mrfVjXBexQj46n8h8QBfk
         T1344EtoSda1ZAm5qFiKFq3CVOTFtyyY+fJeYs+MUPDA/8Gru6ZZbZsQ8nHmRDV0zl6N
         IYMvPoPbKFWO7o4GelzR1e1QfeZZqDfCtDkXRqqIHmLg/7KEcLiYwr66LEU3yA+nmoXB
         KRemeRPDDyKFzxIhB0KkVwOdk0eRJgSCZx48BCBbsIp4It92ScDTuxuiHlS09fG75iBB
         g7d/t9LOFdymahXffPT7cr7/3jPi/kde+88uvSxU2qCz33jE/blrYXxILEs4CBj7tHPM
         XEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781491466; x=1782096266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=BRY3cQe3k+H+ZLNqv6UIkuJ2Ju0wAJuVBYv6h1qoVSKeJgyu7wE+temP9bN00UyNbn
         iBzM2cwtJkTB/f2ulFBju1odtcZoo5itfByJgCLX6s/E9JukRhZVzArVolZMlTwOsDBe
         x8rSUW94t1hiUIaAPy6DelJcfC4wBewNZ8zdLaOBKg4OeMLCZIY6y6F3Hau70hL4bz6l
         YgkKSbkpAabaSK7eMSARKNBNL/sA1Tl67cRYGznjf9V/RgbdwbsXO3kNXTQkNnylwau1
         bZxLN8OmdfJsg3zPnCoH9fuSYhwgSpXYCjIs+OdD6z7ohvFSjQmXKpGB3rcSwDzOtXIW
         aJRg==
X-Forwarded-Encrypted: i=1; AFNElJ92MHS2kou3fYHrrMusy2cv6sdz9O/mD3F17nFxWIkyrgWz2R50rCkx67YHeVR9Pc/xcxxtDbdtfuD+We0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzT2iUFLie1rYKPLL9q3HY8KAldy1XUZ7zgbFl7RQTv3ovIErA1
	6j7p+7rsb10aVWn5HRGeMd+Pz2hs97XtKKCqGVPmXWMlFsGePlj/lOI/
X-Gm-Gg: Acq92OFn3CkB9N5H4+sHy5ooWriSyXezJJF2wFv9SdVDehgICknEdRA/lZ5ARNMDEIR
	0I3kIMkEty5nwxmYZQjMAjL0wimpvt5rXA2GXq9VCFH3vkeW0awIlQYxSoh9EX0rFR8Qa4hpKv6
	C42gaUbDvc5uAfkd5boJhXjcGv0uuntqD2BL3pFh5YjH3o0SZlvDp/jdA4gMYR11MDlZBul4IOx
	qeDQmurPR17wfCgUsWiSAswjONGAJlvRCMotOKPQsIimKZ6mmWK9OkoFMSJdSKQbS8qMt/Pi13r
	j5D51TYnzjENZi2sfSSBHh8sqWVXauIABKX2s34D7J52ecV8nnkINohriIvX9rBX9uV27Lobs8D
	MW2hYMrDO1EnfszMI7iJngN7ZK7kzC6T54v+rAnObF/XUrteZTvT1izysuEHRjHRWwz9ecdgHwO
	4V/OvRzBHVuKIlQC0dlXumBsfF49vpoCsJo45wRUTg2ABtXHlUTuBd93lrCivMaV0=
X-Received: by 2002:a05:6a20:7f95:b0:3b4:8880:2089 with SMTP id adf61e73a8af0-3b783bb0448mr14504694637.16.1781491466271;
        Sun, 14 Jun 2026 19:44:26 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d1d3sm7138676a12.11.2026.06.14.19.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 19:44:25 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 15 Jun 2026 10:46:02 +0800
Subject: [PATCH v8 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20260615-ventura2_initial_dts-v8-1-c89f92c80447@gmail.com>
References: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
In-Reply-To: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=J3z5h5jN99f1BFk7jnvt5xoq1tLRgjc3X0kRzaksvsA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqL2ds9BW16ZZQoO1e5JC8M56v9xEAV+IzijHmA
 lB0RGhp+EKJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCai9nbAAKCRClg0K3CVbE
 gXWgCADCprZUJ0z700syJ6zD139+Wivkz9tcUw6CjgrjNq/OnB+mBhvi3Cq6ed/gVHouqFJptUm
 Fd/0phsYrDe5eT8PXBsktLI0Yrueo2W5QvOgi8PDJUnobF+3XSLjb7ob0hVqqhpuBUz5ltN8/oo
 YMLheoIJVMkiOIddANX65rvHiLupttXtwCUKgVEOVIxe5nvs/c+WwudZqdahS4U84GXM2y8RLRf
 kmMb7l+CyL7Jykgj0F/Bmn1MT/yt5EoiuWr3IVXmC24x+YAVRTLR8u2wybRDB62a03VNKv2ZoJt
 xe8D9O4Fl1GiXWnItAKO9oRU9JLnIgtrb/+MWRTzOcq1ffgP
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..d48607c86e8e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


