From: Barnabás Pőcze <pobrn@protonmail.com>
Date: Mon, 28 Feb 2022 22:50:06 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
 <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
Message-ID: <Ax76nlte5gO6McgVlkdlM8SHBdfYoG0hb6pFO3MJ6iEg3VCk3kzPWFQ6HS2uVDB8eeyLSr4ku62pXF-FrsROsQvF_VDAW1I5lXTFZTkkMfk=@protonmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi


2022. febru?r 28., h?tf? 23:28 keltez?ssel, James Bottomley ?rta:
> [...]
> Well, yes, but my objection is more to the size of churn than the
> desire to do loop local.  I'm not even sure loop local is possible,
> because it's always annoyed me that for (int i = 0; ...  in C++ defines
> i in the outer scope not the loop scope, which is why I never use it.

It is arguably off-topic to the discussion at hand, but I think you might be
thinking of something else (or maybe it was the case in an ancient version of C++)
because that does not appear to be case. If it were,

  for (int i ...) { ... }
  for (int i ...) { ... }

would have to trigger a redeclaration error, but that happens neither in C++ nor in C.
The variable is also inaccessible outside the loop.


> [...]


Regards,
Barnab?s P?cze
