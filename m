Return-Path: <linux-aspeed+bounces-2721-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685F9CCFA03
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 22:46:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0msP5GqTz2xnx;
	Tue,  4 Nov 2025 09:46:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762162439;
	cv=none; b=oEQ+AiSUNEdm3IdTPsSQrQSLpiRm9mfaRjhcv4ZCiZIfIyvdyDyrApaq0sQfWREus/Jm0eI6TPOBhqSadEM72EwhZQHi+qf64z/+zuLd8yrfGLcyo1EbOJ6WOEjupHJbUQeYq/KAwVADYpTgwDttdOYc4GinfrxqH9XskJkOGRcba4Yed6suvFxv7562z0nG21ND9LTsAWZNlH6KohBR6fEJCjckziOzkACDGpaxwLlICPlj046RmD2mevUATNM7LYVKEYdflCGeQlzVppTbzihWmWy6QNnDHyI/TqPuRjwMKNOKeHSSeKD0yv/dikUs8aBQV1rZhaXzWgWW7VgEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762162439; c=relaxed/relaxed;
	bh=jF3tE7PvrhPTALHjWZmN+099uKS6CXrFf6F9PXA5mFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYs96BCoL3rqDNPoSrb3c1K6UMCopzGo255u2hAZKrjXCLoP336g5YINSyzwMy7cXFIILwl+K7kgnNL9xrs73dAI+7Zhf9YrViOHCVuXSQSVeDSssP9KhJxFNOb4xB3dvk0yWxT/nB2bhKq27kRwq0EA0lAUEkWBI5bsdR4BT1YaP54O8JfMwYXhfpEjbmLVH6Lq6fWsEo1b8GLTS8OkEJjLWRUoeMF6kPLphcrRhTMnG3r7jDidFFF1PlPrm4uQKnq46UdYnRPUJuN88K346VV1VcWnrwL+4Xj+EJnp/R/hYni69+81OLMGt2EMmheoYY6kmVCpbZx5Zao01lhsCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d1cFo2Xi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d1cFo2Xi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0RHB45CXz2yFV
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 20:33:58 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so4079956a12.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Nov 2025 01:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762162436; x=1762767236; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF3tE7PvrhPTALHjWZmN+099uKS6CXrFf6F9PXA5mFA=;
        b=d1cFo2XiywpAo8+0tBB3valBjBnCg1ziyNJUzMd0WOzPJtxf4iADA80gzVxIe5al6O
         sChP/16g6j40VIhbxObUiv0NNdIc2gOMbaH9V2zR9LM8JycyvE/+z+6X7GeRsiDlbNpp
         Srwl7ljCcxrZOI1OldcJPKmfN/gKMAdk7U2eMRV83xwejbcRdtCH0utHfRo1esx2Huq0
         3miwmOrqcSqKqkQGK0fbGsK63gSN6nttPzq39t4hICg6iHEnIscnekMoGeICo0jI9zmc
         OghYdJdwEtmjpHZnjugWZLTQ0gEgykppIc2EBIphIu6Hb3oUir8eqMi4k9U6O8+l5ZF9
         1Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162436; x=1762767236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jF3tE7PvrhPTALHjWZmN+099uKS6CXrFf6F9PXA5mFA=;
        b=tRrYk8TT0dXvnJJLmxGpyVfqtX2ROjqmlJCv6dmxpk3XvqaKMS8uT4dVh+4yciEyL6
         wymDhNy+c+H+WWaNxgAfGEt4zJKY+igLWgtSdo4pgyQRNnHI+3kqIeW8fCsosaFmKWvD
         nqzt/2pA6aczyltnkVTGk+tqsZjgr+GvMwvNtLxro/sDS1adcdFvVW2VXySKsDEo0PmO
         k00bRKgukfMED7dBxgPWOgi8vBht4rAVwv0JU5kIWvhvqHw/6vHaBJ311xKRBCWvKV2E
         peD9fKINsh7/V0xJKyY6ZuaIz9TlTfwAz/LeCBZX/GvoW6rjxU8EYpFD22t0DNhOFady
         m4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVlLrOcHB1O+3onMP61UCgtvZVzEDK3FaGoTKfgbXcUOkJUD9PXCiRiggkyHWLjQaUZ5LLSbRAwP6gJIds=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyuEFhQ+LsvDug18+LChK444x2Lgpnxv4ZbZ9YpIs267VBnl/7K
	t/ucxPtWlpHVnkqO+uoPkWYKhrgaSRUkA2FZjJQ324k8nRHI9VYoWXEg7k1dcsTAnfZ1Gw==
X-Gm-Gg: ASbGncvdAIJhbzf6xdV12tkA+i3CBktPbRQ2IXBoLkSEygD630PGHrX8aCFUC082SIs
	UOWPJTTTKDjRs232dI9QW+P8AjPHKxWch7aPUsE0cqiIyCUVO3CtjhqP5pr/NV/51l0VA+T4OKH
	/3zd/Hh6jnKlLVNhn+RaE8+fTFkdq1dLk10sqNHyR5BZSXMMsS/6ex+YoKhx83f3gMm/144Mn2Q
	5gKuBdWDWePxPAJFE00oeV/TdrBVbNtmKh8PJ5S521CXPJNEvMyRiIfEBsz19K7RvaTR5v7T2Qc
	Rjp5ibj6fys4HIVwXH4tMiRLr1irAFeOvDVnL/BQagKr2y8ULmKONUWfzqFJkXCxDzH6/7yL5K9
	s7KNYF8ShZbe2RZDtP6rtOtB5HN4o2W/B/3RqDcrBtS1ibeQCdCAp/sv5ArcGDJygcKpzizzXiw
	/w+PzC
X-Google-Smtp-Source: AGHT+IENCvGrL25P0O0Fc+MRrko1aTk7mSWYGPtk8oKD7ItaFZLfQ0P2sXgV2rrZRmkjGd+q+PpjRQ==
X-Received: by 2002:a17:902:f606:b0:295:7423:530a with SMTP id d9443c01a7336-295742355fdmr75326455ad.29.1762162436497;
        Mon, 03 Nov 2025 01:33:56 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ea51sm112351435ad.57.2025.11.03.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:33:55 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
X-Google-Original-From: Peter Shen <peter.shen@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
Date: Mon,  3 Nov 2025 17:33:19 +0800
Message-Id: <20251103093320.1392256-2-peter.shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103093320.1392256-1-peter.shen@amd.com>
References: <20251103093320.1392256-1-peter.shen@amd.com>
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

This patch adds the compatible string for the Facebook Anacapa BMC
which uses an Aspeed AST2600 SoC. This is required before adding
the board's device tree source file.

Signed-off-by: Peter Shen <peter.shen@amd.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..bcb874ebd9d2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
+              - facebook,anacapa-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc
-- 
2.34.1


