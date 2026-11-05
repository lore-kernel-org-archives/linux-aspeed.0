Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0596606A31B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AoCACtb7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLJcF5lx7z2xHP;
	Fri, 06 Nov 2026 10:36:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793920459;
	cv=pass; b=A+69YIfwpjUmYyRAiAesy2r27rwnDIeN8O9oDRgQ325ksKzEgFCWMgW0dntOtG8SmzSrw+VhpbyJNB1KDedTm0ZsTS5S4UculdG99SlHBw/e7iau2xInEAPJRSu8iid89SauiJPbypWVVitO5GrgNVRVnCxb8tODs2ScRjkzTLbXq+N6yl+Z52hbcySzALt57Glb/zmDKcT91jnAozuf8JUgYhcmEkLHz0Z5m3uytoV9JcnLyAgcD1FlCqLjzsUT08r+ZfmNv9DKlgWTbRW4E9guV5Ass71oTmYi2OFtbBk/2RaeTQyU04boy8535weIBcSpW0BJLfnpQM4EqYzPOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793920459; c=relaxed/relaxed;
	bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a43Z8B/oyVPhzT1HdK/s23EJ82Z5BEZQqt0wm0rmE/THE4QIqrMVa4SUcoRlbxRpzx9+LxAebu5CFZOwgNyOOoaFos6SFlj1JHi2VEyarqZGK37iSroEkd0e80cgFIJgFqIAlxx11QFIZaiTkNnJnJw5VkQICxX3CIUiYPNySEOqiKrGd3IKG+ndawDpPEUzCW53R+tjOCDQgRKNzhPXdX1FyTQkCqi/IzYxFGCe/AvG2B1Tu4VA/UEJp2aNi224ZErEoj2qm9WgG/zLARmJpbHyl+VBnKCsZb6KsFS4U8I8hTdeSYF9w0nCxzwiwQ3I3C2hxSDPCbvKN+0IYv3Hmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AoCACtb7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=AoCACtb7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLJ6L70k8z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 10:14:18 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso25704a12.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 15:14:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=MlHEu4fTFwo8pw2K6P3l3li272V3fqyKpBDUGGbCOBDjKghxhT7lzPykuQeqjnkh15
         0bU3XhncJI7ZWqHoOa0l4pruCGSylICQ2C/+SkVGZhPDirKlYGWLtLrrK8HhwgyJ6P4B
         dkxRNmxRAp8+u3xjZtNaWr9c75yxPwpysJycxxDqJoUY4BMkPi1tukoM1zuLbaEihNtb
         0ginrjuhtwyw5jZ4ZIyBXxuEGucd5bZpW6h6uutLIPLz0vuQaVteyapl6ReLaPk0Fy+t
         JCXsGGuVavsl/UmVxK4zzFFvyR4I7Lo8JSsimDq39dMHqXmnBfyRfyMKr25c77twJa4k
         /Tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=Vt3rYWS71Uaj+s0dAfApOw8OdQNh8hDi3ldVIoNVnzY=;
        b=aJcWxxJrh4h1IFIjwPdbGjssGsMXR7z3ikx1Ywp7Y+r8aTvpUYfBkxw3x36YRwv5hT
         9pLs/M/yAeJetTnn1MJ9Ff2/4ZbsxEqZvcokgkKB4TAj6zIQLTUVV4GN0fQ11gs6BYrV
         VokViPF9wbNsnMO9DOBYMBhqN1aRsoQR8zxgjqZQRW3D001ukHyho1CZjqs9xMuh5YaF
         5ooJiOo1Vjv10/X6Q+mCWIV+nkLbKvsXV2UU1IWnaYE51Vfn7LrdshVe/XRy9BPwLcjg
         4dWOs6++/ujA3J5HBqzdHMTJqFN0Nbt2oPIe/TTWugHtDknrKOQAqic/mbSUZ1c1PSCU
         ca5g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=AoCACtb7tXEVlMa3AfVjoh6GG2UagPSYNuEU50lil9ChBzkaqfYlxX5+y5WchUd1d5
         MQoGODWUmL44O2RWgkMJTDDX/AwnYHejo5V9MhvzMPF9Pz2HqFo1gNyi576ZAi3kxQjE
         fAZU9Ihq7m22mP5HpIWmtjt15QWybX3xDWsh2797oozel2AP8nK69mYntNBGPlsd509V
         KF76GJS2Up2n4z1DYqwtufcWlof8rkpCgtVF/Uu8T7deFFKb+Hybl+rqe8S/RqfMEVcY
         3d4sVUnXtA1QPIxTQBLMyXQG7itm54CZptVDXBcuqXuugh4xxITf7jlSIUlQQxbrlrOI
         zBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=Fkm73ul/NHvcx0Dp2P2NF/K94JevRRdq7BzZfa4qlCu5kwBdVKTOVYn/AEty+FevR/
         eXj/+2QG9HLVf6OI36x+mHE8wxoPFqu8ny4z7K+1SyfA2JzUZES7szbQG50sB7W0njSS
         M1obpWEPWFgJtYSiHTHCavazbVO5h7bhpfemNEk7pRQH/vrc3x1wOGNKSAu4ByXYBOSr
         bU7bmbulc5cDqJdFhGUCtbvQgytOq6mVAcnmfuhresReAUknJR259tNPvcTQ8GpRXZu6
         8p0dY5ZZGgdMeG9B2yc4m6jb68N95BEOK6z1dsOpuWIPwdbQ1BO8Cd1YtVDanrOh1lsk
         yRrQ==
X-Forwarded-Encrypted: i=1; AKwUvByeWlpQ0TLPwnHKwPB+aUYVqzIEEz8eFBLZgSkMPyI2CsHzn/RgugWSslNyfZPN9jnB1b+v2z6J0fw+mkc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8fnqyCyaPklx+oXmkoLa/BnW3YsxBCpK6pLoIfXGCNoBvh+aK4
	/rhcYj4W7ujlx0ArlwCG9AhiqWvWIVYrZMV3qx9x6+KCZPjqtO9qEwKk0DLCOFkHGlYVgI+QDQT
	tCWb+CWTJdonyzJkN2VuFVZ0OekUTkb8fDSU1wn8z
X-Gm-Gg: AYBFou3+TWeA3JLK4z7bolbdZUqoadrYGXJLazB/HugDX0J5pEF/pDPnXBSqrzzeEZf
	29JpcsA1lHjgB+fRKYURdscib59wVIo1nV7L7pNhGOAfZkxpQMgmPfbQZPtr3I+wF9AtfcXlACm
	ur0+iYBxC84D8j6hSBFKtPcCs4AKcQoRMeSgi358kdpY29FVHP4DDCGetYMkb5t2fQG8l7mZJwd
	gUZt8CRZw3kJni1zhc2aawQEWuc0Kuvom+yeNL+4hKLnZXmnkgGQbvjTTqcOeGtfpTqfT4EokKq
	vrhkcb6fc8PnqVxcE9MnutdRiD31b9E8I5vXnlly6SCZZK4NBaYhuTsV9C+RZJoI7BEJ5aFDGUt
	gdpzmVtyl3hTY1gzDiLNPvyGW0dPCh5GTZK3F9ByyvPt+JbcbOUdT0Hql1CfmAyH7kY15
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
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
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

