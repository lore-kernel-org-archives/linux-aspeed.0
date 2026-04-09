Return-Path: <linux-aspeed+bounces-3891-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772C9F45A12
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Apr 2026 02:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsyq10kk5z2xSB;
	Sat, 11 Apr 2026 12:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775734840;
	cv=none; b=kWvPD+WF7XDVbWQ5X/SwoTUri27JsykhfQi+Zy8q/Io5Cm0bbAAS0HbeRCQ6bDwAEkJPJt18KJOJYRzwVbw1iordCISBj4RwOJt0/F00z2I5/kLOGf90lkFhk2S/nMyc58Xu7VcuGdffc14W16ESS551jdNxRlcbu/2d/2tREhJTwMcZnCYjUDazoG54mHNP8M3Qt1eyfCPnM0ya21BP7S82PK3u+GK0G2AIjt44/KFv88+1NG5PdekWt6V6NzHw5blx5778GUHCDx1EPxxCqtu8GY9g53bdR/idaXmT4LJpaSLzJld+kso8PAoAw1IRQb/RO1Dxx+5SD8fTWXI1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775734840; c=relaxed/relaxed;
	bh=aGQ0vmmUWIBnqyUaESvXUUOwisanulkIR/QFZEP+UTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZguTmuSrighJJ30d6qge031QyCIPaN373CFr15eBpPy6kZIwgTHKMd53nuMMTHaqAo9AVLlx1MtX63WtvErZ86RGqsxsNKxEXu1CEn3Ef+iuJ/KQl7jC9CN+AvPVahAtOyQGFpgx7omN/pNpdtNchb9W25N3rK++VziV9Z0uVwF4o5eRCNCcRKQdC6LlY0Fig8t7VylN82pVE27iNJuWY0itFmNylFyULPz4I+84dsr5NXGYn96XmyVsqo195mtxjR6eL12kRuH956J36AURFhMVTGidSIRqY/TLoalFZE9eqxf3c2pQToiUgUvUjqukFSst653ND9rR/AdViPpCWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=URz9PILA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=URz9PILA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fryfv5wt8z2ygf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 21:40:39 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c6e2355739dso367365a12.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775734838; x=1776339638; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGQ0vmmUWIBnqyUaESvXUUOwisanulkIR/QFZEP+UTM=;
        b=URz9PILAuxZNzmJQ3zSFcs2gMrxzxWXZicHw2to9kLkecXeX1Ui/wI0uM5ozjksIOX
         JzK4W5ocsstG2YU9AgUzERHPs4b2Cpzyi9/2saL8IrX86/fTlMJg4V9CeAH25BJJo3+8
         D0hvxwQ3xnxt8JIba5h5PcPx0mqi5HG4W8wxr84mEB1GCWBbrf99dad8GliXVrP7l6gH
         4/3nzOzgFSiaRF2ZAYLOwWy2mCJi4IRAF4P+lng645vy2jwQKGMnxdCkTUfCL7KAmVI2
         WNEwrwi4TuBWKSoBRrRQol6VHUYP/CjSMmAQNgxj5bjpHZAMkGdBlAQZPgIzEOyaUxEI
         NbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734838; x=1776339638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aGQ0vmmUWIBnqyUaESvXUUOwisanulkIR/QFZEP+UTM=;
        b=Ycb3RpXs0ggn/Qu+EKng5OKRQVka8PKX8ZwdYrG8TYnW+YK30rKNEy/SR0W/La6MRy
         MzSwKmKUEkXwhhd8/MJry/FuRfFXItih+vN7E+eDj0hMaYSAwMuAjHp/qr6ayGOVoJNb
         mHIy5p6IIP4GR5bZbcwk5QpEivU7J40zW7TPXQZCO3yPk5ijT9YJL7k6rMmsac+9W+T9
         J0oB1c9IHRqt5i9/rkfI2qeEGfw1vH89cn7Zh7SrIynvOUroLQSDYAFADtBbZgYHB0ZX
         Sw9W4/OY4yWeYIIZvdERhz1Nu8FGFF0tJtolFxk8QiottAl8MTP8XrTvqkK0zvd62zrh
         eoHg==
X-Forwarded-Encrypted: i=1; AJvYcCUK7EZCyUfh3UIpnhv3tEoDALTwSUjqW8yPuQqvKFs8qJweYCnqX3A506KXyxBFIJRBDn/5H9Xab2vf03Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyfpC27NvsNr7Nao0U6m5lvxJE4OEBFXywbA8vuIAEAuQoNaF5O
	NlCLAs4496GabR5s0xN4IJICzxrpN62HyV/wmag68xkuKrJz4Vw5FU8m
X-Gm-Gg: AeBDieuMSxALVzQoq52uPTsTukkDVB8N0gL1USrMH7uvlgdjR4Ush7Cx0V4F9SgqaGZ
	0Q7FIDTb+acMYkQMkg+tXV3RCXyZ0waJDke3lkyij6C2W8X+zyD5LnDhmBZgiR5pdoQBiN0suPx
	RlykuKAeo12UloFAlKb70lNlqEkfQa+LdCaCisbpmPlyfFeZaIwzGHsWuzRH8U65dI+Kl1yo+so
	ePUBJuLnZFeh7zlHo+tXsMUQRTTmzSIHWT4a2C3Tk3fEYwFewCgUbhtiaVoGxQfQPkbMA/PChhD
	umDzdgh87Xqxj1tKKyVDOj2KLxuBFRwJsdqauQOIxr5aVaXxt6GznQ9puBSOW97iTGaGHXanbhP
	7MzYD1VWMRU+U6lTzEh3GNN0HqKkjJ4UyXcn94lj0I6xNDoMA1btdLFSMzGjO/ZYMC65NaC7DXe
	ePOCtcwHFYq3r98xTATmTOsh+mDvjHbw==
X-Received: by 2002:a05:6a20:2e0f:b0:398:ae03:722f with SMTP id adf61e73a8af0-39f2f0a28e5mr18690906637.45.1775734837794;
        Thu, 09 Apr 2026 04:40:37 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659a218sm22438545a12.29.2026.04.09.04.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:40:37 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 09 Apr 2026 19:40:26 +0800
Subject: [PATCH v2 1/3] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2
 board
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
Message-Id: <20260409-anacapa-devlop-phase-devicetree-v2-1-68f328671653@gmail.com>
References: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
In-Reply-To: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775734833; l=882;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=Hk36uMGemdglD1N155LHlYS04DfWcX4jaFk3m0XEMoY=;
 b=qB/7HZdK28u0LjywcyJEq3d12szbQ0c6O5GBzjpklCFTSOFvhUuAZyLpt/R6Mh3FAG1XgBFRw
 NWekkpuc2kNBfOgumwL7gynPmQPmf4JwbQoRS8wAgLuCqgFNC6+wowz
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

Document Anacapa BMC EVT1 and EVT2 compatibles.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 8ec7a3e74a21..c4b87c014941 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -84,6 +84,8 @@ properties:
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
+              - facebook,anacapa-bmc-evt1
+              - facebook,anacapa-bmc-evt2
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc

-- 
2.34.1


