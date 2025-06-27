Return-Path: <linux-aspeed+bounces-1592-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00827C77B7F
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Jun 2025 01:43:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bTZts22gCz306d;
	Sat, 28 Jun 2025 11:43:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751009501;
	cv=none; b=WivrGGGMxhOVJwBwZrhVgRo0FR46EwiGwZNWXjAbbGjZxQy2OwDQkHFlYWuGZ5eSofPaVMRMg9ngEbEQ0Ry9/sDz/L04Mc+d+qNCUzt8af5mlR9Z/tTXBlW4P6AJxy+eTpq4E1QhyETfJk4Ad5ZviHu/M7JgwSJIP8vBNEVTHGUgoYWVpthAh0OztatH7E/qfvd3j4dsK0Rv9CrCXbQyepc/4BG4XMBvBGklSerLnoBvLc6e4YLQ6IhdHeuImHyBcDF2TvxT0KFpHlqWsajTyNrIbpj1F+HmCQPCf4/k/htG2T8JouopEGGmxRT3QBGPUJlY6730OMeml2V0xayFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751009501; c=relaxed/relaxed;
	bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e8jbp5V7E1dkwmJUpdc6/wmU2XWx6pimiM0jDjEbGQMVYE2SCcZDqOibduAZaBbEWt/srDxqKDwFOY7oQv52GEEQMqOzEFDm173Ta/1CpqTu7vEuEVJITA3aAjTBhV859RZ1ffM/QcRqwTW+Rtko442L+sppA3yw2N0i5viNN4o5vSeVp435zA7d18PXbiUpASNbSRniuiZDdcliFlb0UmrL2rlpH4RJSvLJQhqMsVHMCmRHpJ+JKzZbSl1tfU8OkdKLzL9bGcpSYyyzj3WinrcBlx0RpY98kM8vVEbHpiE3ANJPn6mfSpk0tCX626eQRCFRuZu7tAtvzErQWZDLqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AbUAw7ab; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AbUAw7ab;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bT6gc2LQKz2xsW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 17:31:40 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1842500b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751009498; x=1751614298; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=AbUAw7ab/Lp3pPKSSId2fG91Gyranl2LkQM0V3nSlLUEmNm8DvAGbZQt0Vddl8wW9p
         nKfK0q+rO9gsmDxeQQeGYPMBa8F+yqNOXK03TyexIZXXXoSPNKxK3hFyiujyezir8UG6
         LKFJCcYFNy1xLNP2P7iRZUIiX+f5+vwe7jT4rjjM1BgbJESLxzv6KAim0ek5zgWYrhe9
         aExkWc9CI643rvc4s4UMkVggBwjqj/8WHk3RCoE5SCQMWfJCDLuavBzuaUWocBG6/UbK
         Vjr0uacAd1Epyks1s6Gh3FdHHZFpc4ydkSxMj2Eh0sA7ceDI/ZhlxAAz5EpWXI1SpFyL
         /3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751009498; x=1751614298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=fHbdVC1B1CpFFIImDgxcjMb4QkFsVprrXsZ04x5+jA2JeJRIXc4cNzH/Ck9sEB6Xo4
         XhHqNt1+APMLzxAbNl7lLNOzyj8TecS76m1krorv/CBaqnc2O6dOwis89aRxdCVFXTb9
         HJrj+m+byVvmjk9UhZqsCHhMkATdA4UGVoLU50K7XUr2enpb36iukum2FYa9hESzNTC2
         1sfMwpkKhxm+1v87+eGTIqOVDj94B8e6NsrriTE8p9xAcoGgXPBxsmDlJQw5odKfpPEb
         vuDGiQpISZtSvZcTSRPYYUuGPqmHlBeObAkq9Gi6+ZOaw2yyYDf2wk9A+D3s5nWLdkNC
         VCuA==
X-Forwarded-Encrypted: i=1; AJvYcCWZWxKeWyv0XX7ddkusd9iirIshaCbc6FJ+nrhVjIDqcUA7SNV827ocNXGM8o/0jLi7oaPieVTFYU583Qk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywk4jMh7xaEY2vt6Px+K5p5TNcJtluf1d1mFdz1NiblGtlgv/v1
	gZH6IFlsV042tu/0ZKQpmX/VsOTZ2Idc77nGOLNtdjSCuPhbo+p8kxw5
X-Gm-Gg: ASbGncvHQzJd8kOgOFv5fT0d0YfncA7uBomqHoCQPCnUqHcEkGgMgVyjIt0RLV5ZBlR
	bphRNWguXhHMB4WhgDx9MT8xlzAy0Qw2JDDDwV2l8g0bZgQ2qugi24PJjG8dltS+V6D8OWJ/siM
	8dMUl9Rcwhzgmt+kZmqNLPz4R26d7U43NlDMQYnvcnHD3XMUJbZzd1iklykBJpgvXHZ4JcadoTu
	pysqNYB0JcpsY1UYFFEk8Rn4pQDu0Y2r7D24XsBLcWoemo6ujBl2awLKoThkVAbo5Z0H2nrlosl
	Qfghse44z5CRTZEgW+JExTg/OBmQR/2HEUvlb/XmlHsLsqTYqzFek9qTZBf38HqllZCLGyBCviC
	jAZ4kHLHuKPw/7G8I48kWfGuWFc7cQC4=
X-Google-Smtp-Source: AGHT+IECsc8On/+R7tO6ST+8PJjvqWGuxkQi4vIgQwaKYmKT/4qcJMiyQapkOxql4fr0M0zlc4QUEA==
X-Received: by 2002:a05:6a20:394b:b0:203:bb3b:5f03 with SMTP id adf61e73a8af0-220a1251b79mr3468887637.6.1751009498175;
        Fri, 27 Jun 2025 00:31:38 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a8f6sm1628646b3a.12.2025.06.27.00.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:31:37 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Fri, 27 Jun 2025 15:31:21 +0800
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250627-add-support-for-meta-clemente-bmc-v5-1-038ed6f1cb9f@fii-foxconn.com>
References: <20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com>
In-Reply-To: <20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 Leo Wang <leo.jt.wang@fii-foxconn.com>, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751009491; l=886;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=jaJuRFuiQIpQeCgkDZC/ZckoYXAyyJRWtir3QL+VwYw=;
 b=D+RmPFLvbiS065/bwt7uUHl7ONdOQY8Dg4MN24Za+XYvfv5b7lQTjMYSt/GoQgrKrbrwbmw/z
 lnWZsZwQ93ZAQoOvOGe5TVdbZyQ6eGeDHb2qogbq/yEyGijxpWo7enG
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb076582a6c0e801903c3500b459f..ff3fea63cecd99ec2dc56d3cf71403f897681a98 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
+              - facebook,clemente-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc

-- 
2.43.0


