Return-Path: <linux-aspeed+bounces-4099-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17D5CD4F5B
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 20:27:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKmRx3z7Tz2yD6;
	Wed, 20 May 2026 06:27:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779177744;
	cv=none; b=MAEfaIRqmQ+54rEC0cE5iVSlmJdpjK+8lKhhPHYbPP2t2yCdc43+r/jio/CC3Z83HL1jx73yciP+3uziCwKp95dseQKWd04WIJxZdmLuhBfd6zlM142IibRmi9qejxV/vfPfbesLi3u/ak44xUF9E9q12L24gm+/VU7MuWocf/2JYuLEhYPRNQMoS7cBRGRxTWVW6KF/sg3khRdEpZlUvu9g7IWnuijaps96HdYc/RDp2Q4aLgDRRpXMDQ8lByxnbdfhMoX8beIx0GfZPehl3+bXvgyX3oT0fzL4KJUvjafkq2cDI5LlQ7baPN83Rbabf/EqXX0zbkSOGzNb1jIlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779177744; c=relaxed/relaxed;
	bh=p+hlBWVPQXy43hiRxqKhCnwnHHiHzFjw8+7rkTfE8vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VK5TwL2BTnFCtORK9FAHeUfYQkXM77M8bh9XV6HH0XuELvR8ckDZSiwdNu25tUYbaW8C7r22WNXxdS+1fcXOCByEigN0DszybYiE7knUUsU/wWanTIfGPUsFUWocnfE2m178QpLxJfL/FQycy1L7uv1ojgV+NyzSWQH+x5Xk543eIeTGNe6vO6ZGXjbHkAHDrHkM9+pSqqf7Cu06CUfkl/IMWuNkf6PGKUvcWuV449vDufUwCatdJjcB2dJ/inFLP75OvFRmAsEahdYmqyzYDsmTW1ILE8s0jGBWH5eaxWpUg0fyGwldOdx0R0fIEn5N/t6GrSaj0jWfKNNbkA3rUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pt937n9G; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=maoyixie.tju@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pt937n9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=maoyixie.tju@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKRwb11Wsz2xSG
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 18:02:22 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso1159557a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177740; x=1779782540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+hlBWVPQXy43hiRxqKhCnwnHHiHzFjw8+7rkTfE8vA=;
        b=Pt937n9GvlDfu7Rfd71pTS1O6iDx1AmIGpf9tWNaUfHWSj37R0/4vSnoktL1dmOfBs
         UGvemCEDdnhDLKeQRpsn6wNQY6O+bkj05iR05IyqYwYRdnIxOzZtLfJjQvAgo7LKm46I
         WJ28ATgX/tdqUiktlECa8AT3fqdJ8+S11ob1+USbDKGl2Lwv7ykSpyImMOP8Ule7KOke
         puCNBRxVrjjJwPsiMpd+zeodThnZ/6wUl24AkJyX63VCMAoR3KTGFsUr2avnP5+Z0AJR
         UDIQEsSVmm9BX9mRuftGPzMdiAHH9KEsUd343WRFYrN7IOy8RYgr4DkLwKA3dFjcOik8
         N44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177740; x=1779782540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+hlBWVPQXy43hiRxqKhCnwnHHiHzFjw8+7rkTfE8vA=;
        b=cufbC83U3oxiIHU1+CzH66yTUBv4FN4ytuMLmymXIqLpf9OB9GkT3eFbx6Tp9b6Hpn
         XE+N1SbLQmdkPZPBhpYyoYvSRlXYpbSh1VY3wVBzs8YfHb4aJsNn5gjTSjMMKVNA+3bV
         SuYmD7zIhpILBAworhwi5qzWcsN4n422eHtexJGzxjuQgvIIZgJi8WgyZZY8z+hd6Mit
         86qZiwtg3EW5wY6KgSSU94EEYac0ELj6HmFUYjhUlGkv7nsbsYYhzWiypqVAxkL1QVGe
         0X80SATnPhU8WwTRTyIazdM8qAIcwhRQkpt3n9QwFjF3OaZEh4pkxlJrvI/f4w/0d6Di
         cYIw==
X-Forwarded-Encrypted: i=1; AFNElJ8xX5D86bNPsaWagEbqQ4Ab6YNeRUEIqqs3jwjNqS0sWfVVUhJ+ym2kE4dVxrOJA99bktabeXakDwHBbKQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8HvI+tjIYbr59DG2lV5llzv9aCEotIxdm9Ab+sbFiwUG/tJgO
	SnygRSL8ThUqdv5FhJjYlWBpHDel5PDWS3UTVSK2oonU91OhSSRH4d/K
X-Gm-Gg: Acq92OEyqCb+jRFCISyC0vUAntTHBwAPkdobotMb4svedP+mNB3PMAGhNykVR3SI/zW
	I3HoemY8rUrE3xTim2Plzvnf9F2xwNJhA4E8rFe32QMEnnkT0cyOrf9n2hrgMCqQ29MOWoN+Tie
	eRUzgIPRFjUP4pgjzzH4Xav0mYcmHiWB3U/R/Ecxaiqleo0kglokuIz4zERIsGbJj4/jSt3rPUP
	qdzCALR/W2Q+FF5krpDL6rAU/VozRTjJuVp9OpQMI99QDs8fqpvG8yCXYxwuTnDjEBuPzqeNa8Q
	eaAWNKn9IWqoSDQD7hbl9LsLZ5eNOKG0ixCV4+dRmcNQPbsQrS9Bl9ehfiqS4DiDVn2Qj+Bmr2J
	+2KK69RZ6XLhIVMZXp/frZALPt8KQ9YtX1oDX4ZHgvB4eNGolMg8ruCbw1r/UbcuebAW7HtL02m
	egMAG5TJbiKxDx0IgsDALDRxeeFVtELRKwVVvXTt4XkiR8PXbN
X-Received: by 2002:a17:902:7206:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2bd7e8cb16bmr129248565ad.33.1779177739786;
        Tue, 19 May 2026 01:02:19 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0f8efesm181857735ad.55.2026.05.19.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:02:18 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Neal Liu <neal_liu@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: aspeed_udc: avoid past-the-end iterator in dequeue
Date: Tue, 19 May 2026 16:02:13 +0800
Message-Id: <20260519080213.1932516-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518073403.1285339-1-maoyi.xie@ntu.edu.sg>
References: <20260518073403.1285339-1-maoyi.xie@ntu.edu.sg>
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

ast_udc_ep_dequeue() declares the loop cursor `req` outside the
list_for_each_entry(). After the loop it tests `&req->req != _req`
to decide whether the request was found. If the queue holds no
match, `req` is past-the-end. It then aliases
container_of(&ep->queue, struct ast_udc_request, queue) via offset
cancellation. Whether that synthetic address equals `_req` depends
on heap layout. The function can return 0 without dequeueing
anything.

Walk the list with a separate `iter`. Set `req` only when a
request matches. After the loop, `req` is NULL if nothing
matched.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2: Switch the loop body to Alan Stern's shape: test inside
    the if, assign `req`, break. Same behaviour as v1.
v1: https://lore.kernel.org/linux-usb/20260518073403.1285339-1-maoyi.xie@ntu.edu.sg/

 drivers/usb/gadget/udc/aspeed_udc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/usb/gadget/udc/aspeed_udc.c	2026-05-19 15:29:28.690931576 +0800
+++ b/drivers/usb/gadget/udc/aspeed_udc.c	2026-05-19 15:29:59.482953528 +0800
@@ -692,26 +692,30 @@
 {
 	struct ast_udc_ep *ep = to_ast_ep(_ep);
 	struct ast_udc_dev *udc = ep->udc;
-	struct ast_udc_request *req;
+	struct ast_udc_request *req = NULL, *iter;
 	unsigned long flags;
 	int rc = 0;
 
 	spin_lock_irqsave(&udc->lock, flags);
 
 	/* make sure it's actually queued on this endpoint */
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
-			ast_udc_done(ep, req, -ESHUTDOWN);
-			_req->status = -ECONNRESET;
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req == _req) {
+			req = iter;
 			break;
 		}
 	}
 
-	/* dequeue request not found */
-	if (&req->req != _req)
+	if (!req) {
 		rc = -EINVAL;
+		goto out;
+	}
+
+	list_del_init(&req->queue);
+	ast_udc_done(ep, req, -ESHUTDOWN);
+	_req->status = -ECONNRESET;
 
+out:
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	return rc;

-- 
2.34.1

