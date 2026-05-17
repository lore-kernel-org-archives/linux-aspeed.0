Return-Path: <linux-aspeed+bounces-4041-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E024CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 00:01:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJdJJ4CTqz2xvH;
	Mon, 18 May 2026 10:01:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779032783;
	cv=pass; b=C+5lqST0OQc2UF3rHEDwG1pB/7c5qpXVPWq3CTY0UlJrdlJ5wLNLF/bOosVezrhk/HJQUeA+DXcYdoy77evrf9ySxSTn1BXFmWV0R7Aeo+hEPUwcvuzYmqbVub4GSAVt5t0Zdd16438umvUDuy0kM8+yV4wuRrvHCZkLxH7WsuG9+SjiqsbUsqiy0q42ESZ7LFKzRt3pH+aTLrxyW21McGY3gosfeYP7w8CagvhPoMwcyuKkFjAdICfSOUmqjs8PeES3SwOHxpthIE1wY28M+Z+BVbgS3u5rn8AS/qNJe7K8TFy62MSyKqoBqOyUBtiENY76y789p/NZf//zoLqXqw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779032783; c=relaxed/relaxed;
	bh=cYRlW3PCDhz0IzjnRHKXHL7UperzWJzJHc5JdYc23sI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fZSSXMk8Ef7XNouUqLO6ZCDHzo3l0/vPAhjUMHciCEuDVoppBLrkk8dgYDSP2yEsVhKnM/56uXLTRJaiRl9oRx9k5J5QV5IPAaX4Ult8HLsmdCxDTT0uY93PvAVPsbIL9/WbpUnbzOiy5Js3ZvFXNoFzmidP4Ab1Y6FmtlWwuLJCTqsqORoFg5i0bYwg3k3r85H4++1yWHC0+i8JXdiFYTqmRXC/GsIVzaGDV6dNVHf/l7YBGu63nCyO6loNgsVkW3QFnoBrEfWYSZUAbCx+m9fiLpaIDBkgBsSN982DiOg2BEr9RzDg0aY5fSC/lsW8+M2oxAzy7V93+qe+UI7H1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sj69H0Ht; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=maoyixie.tju@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sj69H0Ht;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=maoyixie.tju@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJQJs1MNwz2xWP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 01:46:20 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so1305771f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 17 May 2026 08:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779032776; cv=none;
        d=google.com; s=arc-20240605;
        b=FIZmNiYgoRXdMnjorhGUbuJ+1AkozhMkVLYed/99HtQxn4i/IRUKtpDf/B3wo7Gasr
         tVFpDXC+cS24VEcUNpLlTI7AByCni+vH0YjbxGvq42OtW7RhdlR73kCCpnQuFTC6k1MF
         U0NOvGimrCYtSxHEfi4XP+nefI5ebdKa2FqWAw3pql2FsEXPjTpc0veKyCJ1NEyRkvk8
         j9D0PcJjsO1Yt87rQEoDQB6toNcA0Nw/nIP9HasBXE4FL/eW4C5t9WiGu/jdYd6MpPgx
         zf6mv0oFr8Nu/vdOsq91bFKd2hxajOn3woURi08ipvWA+tp2+u78CwEMQDnzrWHGzHF1
         JYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cYRlW3PCDhz0IzjnRHKXHL7UperzWJzJHc5JdYc23sI=;
        fh=iWPfuFfErmqPCkX+HRinpZhuYd+GSekutORvWom9iKM=;
        b=dpTRiHDuw2rsJeeqTmY4d9BD2RMyyW7mpckrBdFC40NzzPYeJ77YY9kjtFb9ta2+Fv
         VAPwxo5q3D8YZNyxw+cHjZkppXIbEgq+CkzqfjkM+ipFQdLlYhenwvKUHTmsJ4mcOAOV
         NDW5OoAu19Dqxeg6F5Wr522EAZYWsVxt3G/f6NqPqpbdK0XWsUJvQxykksCd/B7XgGEK
         3tY9CPz3Ryes42W/SrvnF2YtZL2BYYx5hxRtMTV3W6GhpLdEf5s0LrZjV8EpMvdnHYcd
         1Ivk1jiUS1OZMcGHCWgNVoQX6SyW3r6UejvF4SQqcg83SNGA/9Ilten/GRYRpWwJr9db
         siGw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779032776; x=1779637576; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYRlW3PCDhz0IzjnRHKXHL7UperzWJzJHc5JdYc23sI=;
        b=sj69H0Ht7a3h6J6bHbIYdYrQjm2xlQQ84Y4lLE4K/qNeusKOSpA4bAkM8t0Ix4n7sI
         YCvsGorzpPFeRErxL+OBjIZ1QNhAnx6VFaQn0OShOO/REXWTxUVOMFl/+dtr2J3f+neA
         vmMiLumv2Ky5WXmRyTIq9mk/B/Yy+seI9eueeYY4yFNMk7gciidzf3g1AEHndr1tFv+J
         hGJsxIWZCrQSomW/BHJsLdwAqFlGvbv722DSxpXvEvMiqoHDHKPOUiDGo3So4gboSEnm
         9N05UAgwMZ8LODOX3uu63RD4bGp+9JUdRdHKcLRHDcJWUjZ29upkuU5UluRLZQPVLFi2
         3ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779032776; x=1779637576;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYRlW3PCDhz0IzjnRHKXHL7UperzWJzJHc5JdYc23sI=;
        b=LAvL0KV3Mi9/HR/Tu5Hr7nr2bhmTniN1sJP5Glb6kndjavFrI/nohGXpn8PkYYXYBk
         mU04lDqviiqE5oyd4wzOJfkcRxq1ggG0FNtCWRxMj231achCZPfaKfewEDHy+dKZdRpG
         Y+hGCCGZ0Cr5LwpKkXTkwp7RSpWttdt5phdSuKvPH2tOMvqhGvFBEfzUGsEw/D7hY9ct
         /gVVjJvOkd7FD19b++7iS6rDj4/RagJ9e4jAoVy2DWUOMeH1XDeds+l4DTmWc1RzsbQH
         7iZWzyPSrMqJQS1LMeOmlr9GpxaaBOWR5OJuHB++y6zGtrKka/QAUMwAjUPt3j7EJK9J
         O2OQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DXHNBkzd7As9bOAFq6z2dmyxzoPRG8dy2BsySjgBaVRmMhUZvCjR9DxnY4YZC1OUW+ohdLr3i17yniww=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7GMj/xq6VjoWktzd7V8GMj/SNz0f26h9rQe46zq3ry9bHHwf+
	kNlpKGBygesjc7EmKN5FONxXp9MNppEA6Qhvlz09ebsOuo8SZ6Yn5OjI9lPXNYwPVPCdDZNDbyn
	0Trq+6imSH4Gl6rwalVn93fTnvi/27HE=
X-Gm-Gg: Acq92OFzhrYbmf9BbeTE5XYOHNG/Rr0Qmf64Lnefe/2WfkWWIhH0mNdAgxFc//Jyo+4
	mYxuPwJsIgi5rfOOY99UdDRqARD+wbDLiUzWJfocb0MuzOWZep5QADSHkN6LKlpKj5K/E6bwZLv
	7B4/IziBiPhd7q9oemI5C8MoG97MWCgtB/uTq3diah6K68YhQec5W6QV+p7Bd8Qs5GizwrUvHnj
	TVHfhjZjMrfZuUzDp9pibVH2uBJMhoipydkjEQspbSmGIbNmB6gAkAr0LTqixcDBwZV9JCoDC4B
	8Xuqljwy
X-Received: by 2002:a5d:584c:0:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-45e5c587396mr16434984f8f.21.1779032776023; Sun, 17 May 2026
 08:46:16 -0700 (PDT)
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
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Sun, 17 May 2026 23:46:04 +0800
X-Gm-Features: AVHnY4LrrtEQK1BvcqcA5igpV4UTqBBKgJzZy77GQaOmTQBQeSdR0fwkPx14Lu4
Message-ID: <CAHPEe=Fs223obDewRunPdTtqhVOM11AXVsLRNHx+=NP0KiFwMQ@mail.gmail.com>
Subject: usb: gadget: aspeed_udc: list iterator used after loop in ast_udc_ep_dequeue
To: neal_liu@aspeedtech.com, gregkh@linuxfoundation.org
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a8c2340652055859"

--000000000000a8c2340652055859
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

(Resending from a personal address =E2=80=94 my previous attempt from
my NTU corporate account carried an auto-appended confidentiality
disclaimer that you've declined to accept. The content below is
unchanged.)

I have been running a small static check for list_for_each_entry
past-the-end patterns, similar to Jakob Koschel's 2022 cleanup
(commit 2966a9918df and related). The check flagged
ast_udc_ep_dequeue() in drivers/usb/gadget/udc/aspeed_udc.c, and I
would like to ask whether you consider this a real defect before I
send anything formal. The same code is present in v7.0 and in
v7.1-rc1 (the two files are byte-identical).

The code in question is around line 691:

    struct ast_udc_request *req;
    ...
    list_for_each_entry(req, &ep->queue, queue) {
        if (&req->req =3D=3D _req) {
            list_del_init(&req->queue);
            ast_udc_done(ep, req, -ESHUTDOWN);
            _req->status =3D -ECONNRESET;
            break;
        }
    }
    if (&req->req !=3D _req)
        rc =3D -EINVAL;

If nothing matches, the loop exits past-the-end and req becomes the
synthetic container_of(&ep->queue, struct ast_udc_request, queue).
Reading &req->req after the loop is undefined per C11. The post-loop
check works in practice only because real _req values do not collide
with that synthetic address.

What made me suspect this was not intentional is that 14 other UDC
drivers in the same directory (at91_udc, atmel_usba_udc, dummy_hcd,
fsl_qe_udc, fsl_udc_core, goku_udc, gr_udc, lpc32xx_udc, max3420_udc,
net2280, omap_udc, pxa25x_udc, pxa27x_udc, udc-xilinx) use a
different pattern, with a separate iter cursor and a result variable.
For example dummy_hcd.c:

    struct dummy_request *req =3D NULL, *iter;
    list_for_each_entry(iter, &ep->queue, queue) {
        if (&iter->req !=3D _req) continue;
        ...
        req =3D iter;
        retval =3D 0;
        break;
    }
    if (retval =3D=3D 0) { ... }

aspeed_udc seems to be the only outlier in drivers/usb/gadget/udc/,
which is what made me think this was probably an oversight rather
than a deliberate idiom.

I also tried to confirm whether it observably misbehaves. If _req
happens to coincide with the synthetic past-the-end address, the
function returns 0 (success) on an empty queue without removing
anything. I attached a small userspace reproducer (poc_aspeed_udc.c
and its output log) that arranges this collision. In normal use _req
comes from the kernel slab and the collision is unlikely to happen
naturally, so I am not sure whether this rises to the level of a
real bug or just a code-quality issue.

Two questions:

  1. Do you consider the past-the-end use here a defect worth fixing,
     or is it an accepted idiom in this driver that I am misreading?

  2. If it is worth fixing, I already have a small patch that brings
     the function in line with the 14 sibling drivers. Would you like
     me to send it, or would you rather address it locally?

Thanks for taking a look, and apologies if I am off base on any of
this.

Best,
Maoyi Xie
--
Nanyang Technological University
https://maoyixie.com/

--000000000000a8c2340652055859
Content-Type: application/octet-stream; name="poc_aspeed_udc.c"
Content-Disposition: attachment; filename="poc_aspeed_udc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mp9y3fo61>
X-Attachment-Id: f_mp9y3fo61

LyoKICogVXNlcnNwYWNlIHJlcHJvZHVjZXIgZm9yIHRoZSBwYXN0LXRoZS1lbmQgaXRlcmF0b3Ig
YmVoYXZpb3IgaW4KICogYXN0X3VkY19lcF9kZXF1ZXVlKCkgKGRyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYXNwZWVkX3VkYy5jKS4KICoKICogQXNwZWVkIFVEQyBpcyBCTUMvQVJNIGhhcmR3YXJlLiBS
YXRoZXIgdGhhbiBicmluZ2luZyB1cCBhIGZ1bGwgU29DCiAqIGVtdWxhdGlvbiwgdGhpcyBwcm9n
cmFtIGV4dHJhY3RzIHRoZSBkZXF1ZXVlIGZ1bmN0aW9uJ3MgbG9naWMgaW50bwogKiB1c2Vyc3Bh
Y2UgdXNpbmcgbW9jayBzdHJ1Y3RzIHdob3NlIGxheW91dCAocmVxIGF0IG9mZnNldCAwLCBxdWV1
ZQogKiBpbW1lZGlhdGVseSBhZnRlcikgbWF0Y2hlcyB0aGUga2VybmVsIGRlZmluaXRpb24uIEl0
IHRoZW4gcnVucyBib3RoCiAqIHRoZSBleGlzdGluZyBjb2RlIHBhdGggYW5kIHRoZSBwcm9wb3Nl
ZCBmaXggb24gdGhlIHNhbWUgY3JhZnRlZCBpbnB1dC4KICoKICogQnVpbGQ6IGNjIC1PMCAtZyBw
b2NfYXNwZWVkX3VkYy5jIC1vIHBvY19hc3BlZWRfdWRjCiAqIFJ1bjogICAuL3BvY19hc3BlZWRf
dWRjICAgICAgICAgICAoZXhpc3RpbmcgY29kZSwgcmV0dXJucyA0MikKICogICAgICAgIC4vcG9j
X2FzcGVlZF91ZGMgcGF0Y2hlZCAgIChwcm9wb3NlZCBmaXgsIHJldHVybnMgMCkKICovCiNkZWZp
bmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2lu
Y2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3RkZGVmLmg+CgovKiBNaW5pbWFsIG1vY2sgb2Yg
dGhlIGtlcm5lbCBsaXN0X2hlYWQgYW5kIGNvbnRhaW5lcl9vZi4gKi8Kc3RydWN0IGxpc3RfaGVh
ZCB7IHN0cnVjdCBsaXN0X2hlYWQgKm5leHQsICpwcmV2OyB9OwoKI2RlZmluZSBjb250YWluZXJf
b2YocHRyLCB0eXBlLCBtZW1iZXIpIFwKICAgICgodHlwZSAqKSgoY2hhciAqKShwdHIpIC0gb2Zm
c2V0b2YodHlwZSwgbWVtYmVyKSkpCgojZGVmaW5lIGxpc3RfZmlyc3RfZW50cnkocHRyLCB0eXBl
LCBtZW1iZXIpIFwKICAgIGNvbnRhaW5lcl9vZigocHRyKS0+bmV4dCwgdHlwZSwgbWVtYmVyKQoj
ZGVmaW5lIGxpc3RfbmV4dF9lbnRyeShwb3MsIG1lbWJlcikgXAogICAgY29udGFpbmVyX29mKChw
b3MpLT5tZW1iZXIubmV4dCwgdHlwZW9mKCoocG9zKSksIG1lbWJlcikKI2RlZmluZSBsaXN0X2Vu
dHJ5X2lzX2hlYWQocG9zLCBoZWFkLCBtZW1iZXIpIFwKICAgICgmKHBvcyktPm1lbWJlciA9PSAo
aGVhZCkpCgojZGVmaW5lIGxpc3RfZm9yX2VhY2hfZW50cnkocG9zLCBoZWFkLCBtZW1iZXIpICAg
ICAgICAgICAgICAgXAogICAgZm9yIChwb3MgPSBsaXN0X2ZpcnN0X2VudHJ5KGhlYWQsIHR5cGVv
ZigqcG9zKSwgbWVtYmVyKTsgXAogICAgICAgICAhbGlzdF9lbnRyeV9pc19oZWFkKHBvcywgaGVh
ZCwgbWVtYmVyKTsgICAgICAgICAgICAgXAogICAgICAgICBwb3MgPSBsaXN0X25leHRfZW50cnko
cG9zLCBtZW1iZXIpKQoKc3RhdGljIHZvaWQgbGlzdF9pbml0KHN0cnVjdCBsaXN0X2hlYWQgKmgp
IHsgaC0+bmV4dCA9IGgtPnByZXYgPSBoOyB9CgovKiBNb2NrIHN0cnVjdHMuIE9ubHkgZmllbGQg
b3JkZXIgbWF0dGVyczogcmVxIGF0IG9mZnNldCAwLCBxdWV1ZQogKiBpbW1lZGlhdGVseSBhZnRl
ci4gKi8Kc3RydWN0IHVzYl9yZXF1ZXN0IHsKICAgIHZvaWQgKmJ1ZjsKICAgIHVuc2lnbmVkIGxl
bmd0aDsKICAgIGludCBzdGF0dXM7Cn07CgpzdHJ1Y3QgYXN0X3VkY19yZXF1ZXN0IHsKICAgIHN0
cnVjdCB1c2JfcmVxdWVzdCByZXE7CiAgICBzdHJ1Y3QgbGlzdF9oZWFkIHF1ZXVlOwogICAgaW50
IHBhZDsKfTsKCnN0cnVjdCBhc3RfdWRjX2VwIHsKICAgIHN0cnVjdCBsaXN0X2hlYWQgcXVldWU7
Cn07CgovKiBFeGlzdGluZyBjb2RlIHBhdGggZnJvbSBhc3BlZWRfdWRjLmMgYXJvdW5kIGxpbmUg
NjkxLiBMb2NrcyBhbmQKICogdGhlIGFzdF91ZGNfZG9uZSgpIGNhbGxiYWNrIGFyZSBlbGlkZWQg
c2luY2UgdGhlIHBhc3QtdGhlLWVuZAogKiBiZWhhdmlvciBpcyBpbmRlcGVuZGVudCBvZiB0aGVt
LiAqLwpzdGF0aWMgaW50IGFzdF91ZGNfZXBfZGVxdWV1ZV9leGlzdGluZyhzdHJ1Y3QgYXN0X3Vk
Y19lcCAqZXAsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dXNiX3JlcXVlc3QgKl9yZXEpCnsKICAgIHN0cnVjdCBhc3RfdWRjX3JlcXVlc3QgKnJlcTsKICAg
IGludCByYyA9IDA7CgogICAgbGlzdF9mb3JfZWFjaF9lbnRyeShyZXEsICZlcC0+cXVldWUsIHF1
ZXVlKSB7CiAgICAgICAgaWYgKCZyZXEtPnJlcSA9PSBfcmVxKSB7CiAgICAgICAgICAgIC8qIGxp
c3RfZGVsX2luaXQgKyBhc3RfdWRjX2RvbmUgKyBzZXQgc3RhdHVzIGhlcmUgKi8KICAgICAgICAg
ICAgYnJlYWs7CiAgICAgICAgfQogICAgfQoKICAgIC8qIFdoZW4gdGhlIGxvb3AgZmluZHMgbm8g
bWF0Y2gsIHJlcSBpcyBwYXN0LXRoZS1lbmQuIFJlYWRpbmcKICAgICAqICZyZXEtPnJlcSBpcyB1
bmRlZmluZWQgcGVyIEMxMTsgdGhlIHJlc3VsdGluZyBjaGVjayBpcyBhCiAgICAgKiBwcm9wZXJ0
eSBvZiBoZWFwIGxheW91dCByYXRoZXIgdGhhbiB0aGUgcXVldWUgY29udGVudHMuICovCiAgICBp
ZiAoJnJlcS0+cmVxICE9IF9yZXEpCiAgICAgICAgcmMgPSAtMjI7ICAgICAvKiAtRUlOVkFMICov
CgogICAgcmV0dXJuIHJjOwp9CgovKiBQcm9wb3NlZCBmaXggdXNpbmcgdGhlIHNlcGFyYXRlIGl0
ZXIgY3Vyc29yIHBhdHRlcm4gc2hhcmVkIGJ5IHRoZQogKiBvdGhlciBVREMgZHJpdmVycyBpbiB0
aGUgc2FtZSBkaXJlY3RvcnkgKGUuZy4gZHVtbXlfaGNkLmMpLiAqLwpzdGF0aWMgaW50IGFzdF91
ZGNfZXBfZGVxdWV1ZV9wYXRjaGVkKHN0cnVjdCBhc3RfdWRjX2VwICplcCwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHVzYl9yZXF1ZXN0ICpfcmVxKQp7CiAg
ICBzdHJ1Y3QgYXN0X3VkY19yZXF1ZXN0ICpyZXEgPSBOVUxMLCAqaXRlcjsKCiAgICBsaXN0X2Zv
cl9lYWNoX2VudHJ5KGl0ZXIsICZlcC0+cXVldWUsIHF1ZXVlKSB7CiAgICAgICAgaWYgKCZpdGVy
LT5yZXEgIT0gX3JlcSkKICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgcmVxID0gaXRlcjsK
ICAgICAgICBicmVhazsKICAgIH0KCiAgICBpZiAoIXJlcSkKICAgICAgICByZXR1cm4gLTIyOyAg
ICAgLyogLUVJTlZBTCAqLwoKICAgIC8qIGxpc3RfZGVsX2luaXQgKyBhc3RfdWRjX2RvbmUgKyBz
ZXQgc3RhdHVzIGhlcmUgKi8KICAgIHJldHVybiAwOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqKmFyZ3YpCnsKICAgIGludCB1c2VfcGF0Y2hlZCA9IChhcmdjID4gMSAmJiAhc3RyY21wKGFy
Z3ZbMV0sICJwYXRjaGVkIikpOwoKICAgIHN0cnVjdCBhc3RfdWRjX2VwIGVwOwogICAgbGlzdF9p
bml0KCZlcC5xdWV1ZSk7CgogICAgLyogQW4gZW1wdHkgcXVldWUgZm9yY2VzIHRoZSBleGlzdGlu
ZyBjb2RlJ3MgaXRlcmF0b3IgcGFzdCB0aGUgZW5kLgogICAgICogcGFzdF9lbmQgaXMgdGhlIHN5
bnRoZXRpYyBhc3RfdWRjX3JlcXVlc3QgcG9pbnRlciB0aGUgbG9vcCB3aWxsCiAgICAgKiBsZWF2
ZSBiZWhpbmQuIEJlY2F1c2UgcmVxIGlzIHRoZSBmaXJzdCBtZW1iZXIsICZwYXN0X2VuZC0+cmVx
CiAgICAgKiBoYXMgdGhlIHNhbWUgbnVtZXJpYyB2YWx1ZSBhcyBwYXN0X2VuZCBpdHNlbGYuICov
CiAgICBzdHJ1Y3QgYXN0X3VkY19yZXF1ZXN0ICpwYXN0X2VuZCA9CiAgICAgICAgY29udGFpbmVy
X29mKCZlcC5xdWV1ZSwgc3RydWN0IGFzdF91ZGNfcmVxdWVzdCwgcXVldWUpOwogICAgc3RydWN0
IHVzYl9yZXF1ZXN0ICpmYWtlX3JlcSA9ICZwYXN0X2VuZC0+cmVxOwoKICAgIHByaW50ZigiW3Nl
dHVwXSBlcC5xdWV1ZT0lcCAoaGVhZClcbiIsICh2b2lkICopJmVwLnF1ZXVlKTsKICAgIHByaW50
ZigiW3NldHVwXSBwYXN0X2VuZD0lcFxuIiwgKHZvaWQgKilwYXN0X2VuZCk7CiAgICBwcmludGYo
IltzZXR1cF0gZmFrZV9yZXE9JXBcbiIsICh2b2lkICopZmFrZV9yZXEpOwoKICAgIGludCByYzsK
ICAgIGlmICh1c2VfcGF0Y2hlZCkgewogICAgICAgIHJjID0gYXN0X3VkY19lcF9kZXF1ZXVlX3Bh
dGNoZWQoJmVwLCBmYWtlX3JlcSk7CiAgICAgICAgcHJpbnRmKCJbcHJvYmVdIHBhdGNoZWQgcmM9
JWRcbiIsIHJjKTsKICAgIH0gZWxzZSB7CiAgICAgICAgcmMgPSBhc3RfdWRjX2VwX2RlcXVldWVf
ZXhpc3RpbmcoJmVwLCBmYWtlX3JlcSk7CiAgICAgICAgcHJpbnRmKCJbcHJvYmVdIGV4aXN0aW5n
IHJjPSVkXG4iLCByYyk7CiAgICB9CgogICAgaWYgKHJjID09IDApIHsKICAgICAgICBwcmludGYo
IltyZXN1bHRdIHJldHVybmVkIDAgKHN1Y2Nlc3MpIG9uIGVtcHR5IHF1ZXVlIHdpdGhvdXQgIgog
ICAgICAgICAgICAgICAicmVtb3ZpbmcgYW55dGhpbmdcbiIpOwogICAgICAgIHJldHVybiA0MjsK
ICAgIH0KICAgIHByaW50ZigiW3Jlc3VsdF0gcmV0dXJuZWQgJWQgKHJlamVjdGVkKVxuIiwgcmMp
OwogICAgcmV0dXJuIDA7Cn0K
--000000000000a8c2340652055859
Content-Type: application/octet-stream; name="poc_aspeed_udc.log"
Content-Disposition: attachment; filename="poc_aspeed_udc.log"
Content-Transfer-Encoding: base64
Content-ID: <f_mp9y3fnz0>
X-Attachment-Id: f_mp9y3fnz0

JCAuL3BvY19hc3BlZWRfdWRjCltzZXR1cF0gZXAucXVldWU9MHg3ZmZlZmUwYjFjZDAgKGhlYWQp
CltzZXR1cF0gcGFzdF9lbmQ9MHg3ZmZlZmUwYjFjYzAKW3NldHVwXSBmYWtlX3JlcT0weDdmZmVm
ZTBiMWNjMApbcHJvYmVdIGV4aXN0aW5nIHJjPTAKW3Jlc3VsdF0gcmV0dXJuZWQgMCAoc3VjY2Vz
cykgb24gZW1wdHkgcXVldWUgd2l0aG91dCByZW1vdmluZyBhbnl0aGluZwoKJCAuL3BvY19hc3Bl
ZWRfdWRjIHBhdGNoZWQKW3NldHVwXSBlcC5xdWV1ZT0weDdmZmVlNjQ4ZWVlMCAoaGVhZCkKW3Nl
dHVwXSBwYXN0X2VuZD0weDdmZmVlNjQ4ZWVkMApbc2V0dXBdIGZha2VfcmVxPTB4N2ZmZWU2NDhl
ZWQwCltwcm9iZV0gcGF0Y2hlZCByYz0tMjIKW3Jlc3VsdF0gcmV0dXJuZWQgLTIyIChyZWplY3Rl
ZCkK
--000000000000a8c2340652055859--

