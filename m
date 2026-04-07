Return-Path: <linux-aspeed+bounces-3861-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F012105D990
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 23:21:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr2J8710Jz2yfS;
	Wed, 08 Apr 2026 09:21:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775549879;
	cv=none; b=adpZbqBqbXMBnOBlnSkHuLlWY2830ULOM1u3ftufrBN0i9BU9PsMHIw2fgbpcIpEojMG1DnXBQg9FYI9Tcuv4hD41TtAGE2j4EhDooHS2QuUu0QupxV13pNDWML3DDGxLE+LuvOOlCPu/7f4xmTocIY02MPhh1N5mJRjq4Y0mBxLPvyiyNH9gCkCiovvLfyv6vjVYHsk+SSHBAhT46zCNEQeBl7TCG2gqtqJzMeV5uPP70yfWdIhQqaOvZaCvnt5W4l07JO7SDL10xDAeuRJv/ohyzCG0qx1ae8M4ZmOjhHsMrAp+fZFmdLvbCAwPEkDcD76eOvIr2R0eyO1C14S+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775549879; c=relaxed/relaxed;
	bh=2M1mDfXgnz5T52hMj8GNJ84lRse5GAheeg5uX9GLBPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKwBrBhffCoCemlXEXO7g2tS4HrKD/s47wdIVgsyK9ecPQBEr7k/pw3MqoGwL31Ji8twvCL9m6GYP8ctIIhbbVeDMDvpgOroK5+5gJeZ7J62nYP3mh99TcTE2q/gMT8u1OZh5j+2eH2g0Glq7mHXkUIgrZarx7xBS0QKai9JW95iyX7dFpxLiGKdj+ypkw/LC91AoXlpAPCcn/chQGqkFy+Q6jgx53iivlPBPjhzA+K8zGpycMEhJxgFaZUQnuBvmT2IsAq1GfMQNym5S1NnnYlsAvN3S1g+2vvl1ltlblRzGT5qZfaLJaqkJxFm3A9El+T8ex5d8PQwb7//uEsdOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fJFHSs+L; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fJFHSs+L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqfFy4qPhz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 18:17:58 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2621264a91.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775549877; x=1776154677; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M1mDfXgnz5T52hMj8GNJ84lRse5GAheeg5uX9GLBPU=;
        b=fJFHSs+LuYIot+ua0h1QqZ7Ll/2uutPZtb9ghclxhybMmglhBG0zxzznVYhR7PgAsv
         CB8f+IYuC8ykYVt+Dq4NE3b8I5zPSBTndHkve7JcomE9IoPL44Uud8v2wiP8Qfafh7YD
         BCgC/KKQ2BalVsJ7OXUGipZwfysl11kpYv4zsngOeM2DWHngmpLTbdOWHlkNaA0CZ9Tx
         ITJVvBtqUabTn4lQ4E+gnGiw+ghEQnzUl+04ip9YgPlZoxKRfbvNnte7lEzSehzvTHmY
         Oam/3IAmAHk8gd62NiSasVgS7aV6pLgufMmVyZwwIlv6vDc84cs45Pmk0mG5wBDHzyLh
         7POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549877; x=1776154677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2M1mDfXgnz5T52hMj8GNJ84lRse5GAheeg5uX9GLBPU=;
        b=rtpPEmTW1d7R+5h9xfd2XoZkzhKjYbdwAplvbqkjOtNlxDznjRIrSEMDbrrxqvHSal
         F9XHtKC44w+GbbEmPbsI1Cqn5UM/V2EFprj+QZVW9ur5t28mjYi3uIWtqIWH6RQlCk05
         M9dnp73D5Tjagg7cBvAj0eAp5AnmCJlUlAeTBuvMIvsSr6iRUYVES0ckOi1R6zlFd6Do
         uI/sApeYFB9lx20RctpNJOc6F9IirrGHMo/pRKRNYFqYeiykHlFx2RrO4C9M2As66U4y
         MQTnAsuEOlkAOWqXS2fEPYu434jHuu+xIFoFM9iSMN2Vz+WM4X7HMXkxrWVRRhxCrEWz
         N17Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxQ+aa3auBczVtFPMVxT8gofPe75/iA8hW+H6MKeVuoICFsw0APx1ZdyzLnga8QC0zFciJLzzRuABnuNc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQcGh7zikSAyxS6RQFdUH6PFcVtslYfO1tKH4+pIIlD6JVyjIL
	WHoQaOdFMMyVl8X3ubqLQHx+Dzmzkp5gOBtnCRkSwSOpMRdS+auD9G60
X-Gm-Gg: AeBDievZ8sMd529AU2BLy6LqJfxqO5C3iO4uzYQ0DsAKSq7euQVq6aGDikMKSMLA97P
	pyVubTbdfPzTdfr6semPrf4e946HHoix+yol5B6nCw+V4ryYYWiu3aRPF+CpBqkkVIunYNNM5fH
	MXY46tZmOZ3C4JupFXm7RnFTuCJr1WrrWFhwqGHm4HVkl+QD+I2UTv0rhMNfrww+aM0YnzjFbDx
	exS7G1BFyw2xMYAZTmeOk+jq6okpl4EFaCu8LQLnxd03N7qngkg4mjtkGr0435zxm9Fg3+LkQaT
	f3X8rMLAU6CQ6J2Y3sDNP4Ge2KEf1WglSizFXM2vthL9pFjxTKwq84+7YvajQsqrH6wsKOkRzXv
	ff96esXba3X5B8PI+XNIWxFzNV4RFCGyDvsyn0vFy1vsg/fmgSXx0RzfMBTwpEzQPUzVilQxrc9
	LaYOCET4sn3ifF/wxBqmrn2Jb7d+9q2vapltGRLLGj1pHO0hAY4bqpJsAtWgmmmVeLEJKuvyHRE
	I6qQY9bPir0
X-Received: by 2002:a17:90b:4b92:b0:35b:e4d8:e21d with SMTP id 98e67ed59e1d1-35de678f2c8mr14931420a91.2.1775549876544;
        Tue, 07 Apr 2026 01:17:56 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de6a2325bsm4592889a91.12.2026.04.07.01.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:56 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Jason-Hsu@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v13 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Tue,  7 Apr 2026 16:16:59 +0800
Message-ID: <20260407081700.2658011-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407081700.2658011-1-pkleequanta@gmail.com>
References: <20260407081700.2658011-1-pkleequanta@gmail.com>
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

Document the new compatibles used on Meta Ventura.

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..afabfe22c8f3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.43.0


